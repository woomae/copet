import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { CommentRepository } from './comments.repository';
import { Comments } from './comments.entity';

@Injectable()
export class CommentsService {
  constructor(
    @InjectRepository(CommentRepository)
    private commentRepository: CommentRepository,
  ) {}
  async getAllCommentsByArticle(
    connected_article_id: number,
  ): Promise<Comments[]> {
    const result =
      await this.commentRepository.getAllCommentsByArticle(
        connected_article_id,
      );
    return result;
  }
  //   async createComment(bodyData: any): Promise<void> {

  //     return await this.commentRepository.createComment(bodyData);
  //   }
}
