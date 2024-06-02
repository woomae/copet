import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { CommentRepository } from './comments.repository';
import { Comments } from './comments.entity';
import { UsersService } from '../users/users.service';
import { ArticlesService } from '../articles/articles.service';
import { CreateCommentDto } from 'src/dto/create-comment.dto';
import ApiError from 'src/libs/res/api.errors';
import ApiCodes from 'src/libs/res/api.codes';
import ApiMessages from 'src/libs/res/api.messages';

@Injectable()
export class CommentsService {
  constructor(
    @InjectRepository(CommentRepository)
    private commentRepository: CommentRepository,
    private usersService: UsersService,
    private articlesService: ArticlesService,
  ) {}
  async getAllCommentsByArticle(
    article_id: number,
  ): Promise<[Object, Comments[]]> {
    const found =
      await this.commentRepository.getAllCommentsByArticle(article_id);

    return [{ count: found[1] }, found[0]];
  }
  async createComment(
    id: number,
    article_id: number,
    bodyData: CreateCommentDto,
  ): Promise<void> {
    bodyData.nickname = (await this.usersService.findUserById(id)).nickname;
    bodyData.owner_id = id;
    bodyData.article_id = article_id;
    await this.articlesService.increaseCommentCount(article_id);
    return await this.commentRepository.createComment(bodyData);
  }
  async updateComment(
    _id: number,
    user_id: number,
    commentText: string,
  ): Promise<Comments> {
    const comment = await this.commentRepository.getcommentById(_id);
    if (!comment) {
      throw new ApiError(ApiCodes.BAD_REQUEST, ApiMessages.BAD_REQUEST, {
        message: 'Comment not found',
      });
    }
    if (comment.owner_id !== user_id) {
      throw new ApiError(ApiCodes.BAD_REQUEST, ApiMessages.BAD_REQUEST, {
        message: 'You are not the owner of the comment',
      });
    }
    return await this.commentRepository.updateComment(_id, commentText);
  }

  async deleteComment(_id: number, user_id: number): Promise<void> {
    const comment = await this.commentRepository.getcommentById(_id);
    if (!comment) {
      throw new ApiError(ApiCodes.BAD_REQUEST, ApiMessages.BAD_REQUEST, {
        message: 'Comment not found',
      });
    }
    if (comment.owner_id !== user_id) {
      throw new ApiError(ApiCodes.BAD_REQUEST, ApiMessages.BAD_REQUEST, {
        message: 'You are not the owner of the comment',
      });
    }
    await this.articlesService.decreaseCommentCount(comment.article_id);
    await this.commentRepository.deleteComment(_id);
  }
}
