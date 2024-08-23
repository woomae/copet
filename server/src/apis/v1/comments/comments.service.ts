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
import { UpdateCommentDto } from 'src/dto/update-comment.dto';
import { NotificationsService } from '../notifications/notifications.service';
import { commentPayloads } from 'src/libs/notifications/payloads/commentPayloads';

@Injectable()
export class CommentsService {
  constructor(
    @InjectRepository(CommentRepository)
    private commentRepository: CommentRepository,
    private usersService: UsersService,
    private articlesService: ArticlesService,
    private notificationsService: NotificationsService,
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
    bodyData: CreateCommentDto,
  ): Promise<Comments> {
    bodyData.nickname = (await this.usersService.findUserById(id)).nickname;
    bodyData.owner_id = id;
    await this.articlesService.increaseCommentCount(bodyData.article_id);
    const result = await this.commentRepository.createComment(bodyData);
    //알림 전송
    const receiveUserId = (
      await this.articlesService.getArticleById(id, bodyData.article_id)
    ).owner_id;
    await this.notificationsService.sendNotification(
      receiveUserId,
      id,
      commentPayloads,
    );
    return result;
  }
  async updateComment(
    id: number,
    user_id: number,
    updateCommentDto: UpdateCommentDto,
  ): Promise<Comments> {
    const comment = await this.commentRepository.getcommentById(id);
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
    return await this.commentRepository.updateComment(
      id,
      updateCommentDto.comment,
    );
  }

  async deleteComment(id: number, user_id: number): Promise<void> {
    const comment = await this.commentRepository.getcommentById(id);
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
    await this.commentRepository.deleteComment(id);
  }
}
