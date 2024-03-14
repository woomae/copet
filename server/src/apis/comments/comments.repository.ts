import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { Comments } from './comments.entity';

@Injectable()
export class CommentRepository extends Repository<Comments> {
  constructor(dataSource: DataSource) {
    super(Comments, dataSource.createEntityManager());
  }
  async getAllCommentsByArticle(connected_article_id: number) {
    return await this.findBy({ connected_article_id: connected_article_id });
  }
}
