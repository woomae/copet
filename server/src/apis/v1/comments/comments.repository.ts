import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { Comments } from './comments.entity';
import { CreateCommentDto } from 'src/dto/create-comment.dto';

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
  async getcommentById(id: number) {
    return await this.findOneBy({ _id: id });
  }
  async createComment(bodyData: CreateCommentDto): Promise<Comments> {
    return await this.save(bodyData);
  }
  async updateComment(id: number, comment: string) {
    await this.update({ _id: id }, { comment: comment });
    return await this.findOneBy({ _id: id });
  }
  async deleteComment(id: number) {
    return await this.delete({ _id: id });
  }
}
