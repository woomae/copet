import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { Comments } from './comments.entity';

@Injectable()
export class CommentRepository extends Repository<Comments> {
  constructor(dataSource: DataSource) {
    super(Comments, dataSource.createEntityManager());
  }
  async getAllCommentsByArticle(
    article_id: number,
  ): Promise<[Comments[], number]> {
    const found = await this.createQueryBuilder('comments')
      .leftJoin('comments.article_id', 'article')
      .where('comments.article_id = :article_id', {
        article_id: article_id,
      })
      .getManyAndCount();
    return found;
  }
  async getcommentById(_id: number) {
    return await this.findOneBy({ _id: _id });
  }
  async createComment(bodyData: any): Promise<void> {
    return await this.save(bodyData);
  }
  async updateComment(_id: number, comment: string) {
    await this.update({ _id: _id }, { comment: comment });
    return await this.findOneBy({ _id: _id });
  }
  async deleteComment(_id: number) {
    return await this.delete({ _id: _id });
  }
}
