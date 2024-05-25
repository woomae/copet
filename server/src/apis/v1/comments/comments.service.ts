import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { CommentRepository } from './comments.repository';
import { Comments } from './comments.entity';
import { UsersService } from '../users/users.service';
import { ArticlesService } from '../articles/articles.service';
import { CreateCommentDto } from 'src/dto/create-comment.dto';

@Injectable()
export class CommentsService {
  constructor(
    @InjectRepository(CommentRepository)
    private commentRepository: CommentRepository,
    private usersService: UsersService,
    private articlesService: ArticlesService,
  ) {}
  async getAllCommentsByArticle(
    connected_article_id: number,
  ): Promise<Comments[]> {
    const found =
      await this.commentRepository.getAllCommentsByArticle(
        connected_article_id,
      );
    if (!found || found.length === 0) {
      throw new BadRequestException(
        `Comments with ID "${connected_article_id}" not found`,
      );
    }
    return found;
  }
  async createComment(bodyData: CreateCommentDto): Promise<void> {
    bodyData.nickname = (
      await this.usersService.findUserById(bodyData.user_id)
    ).nickname;
    bodyData.comment_owner_id = bodyData.user_id;
    if (
      !bodyData.connected_article_id ||
      !bodyData.comment ||
      !bodyData.nickname
    ) {
      throw new BadRequestException(`Please check your input data`);
    }
    await this.articlesService.increaseCommentCount(
      bodyData.connected_article_id,
    );
    return await this.commentRepository.createComment(bodyData);
  }
  async deleteComment(comment_id: number, user_id: number): Promise<void> {
    //넘어온값들 올바른지 확인할것
    //코멘트체크, 오너체크
    const comment = await this.commentRepository.getcommentById(comment_id);
    if (!comment) {
      throw new BadRequestException(
        `Comment with ID "${comment_id}" not found`,
      );
    }
    if (comment.comment_owner_id !== user_id) {
      throw new BadRequestException(
        `You are not the owner of the comment with ID "${comment_id}"`,
      );
    }
    await this.articlesService.decreaseCommentCount(
      comment.connected_article_id,
    );
    await this.commentRepository.deleteComment(comment_id);
  }
}
