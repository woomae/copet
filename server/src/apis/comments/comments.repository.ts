import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { Comments } from './comments.entity';

@Injectable()
export class CommentRepository extends Repository<Comments> {
  constructor(dataSource: DataSource) {
    super(Comments, dataSource.createEntityManager());
  }
  async getAllCommentsByArticle(connected_article_id: number) {
    const found = await this.createQueryBuilder('comments')
      .leftJoin('comments.connected_article_id', 'article')
      .where('comments.connected_article_id = :connected_article_id', {
        connected_article_id: connected_article_id,
      })
      .getMany();
    return found;
  }
  async getcommentById(comment_id: number) {
    return await this.findOneBy({ comment_id: comment_id });
  }
  async createComment(bodyData: any): Promise<void> {
    return await this.save(bodyData);
  }
  async deleteComment(comment_id: number) {
    return await this.delete({ comment_id: comment_id });
  }
}
