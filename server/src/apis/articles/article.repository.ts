import { Injectable } from '@nestjs/common';
import { Article } from './article.entity';
import { DataSource, Repository } from 'typeorm';

@Injectable()
export class ArticleRepository extends Repository<Article> {
  constructor(dataSource: DataSource) {
    super(Article, dataSource.createEntityManager());
  }
  async getArticleById(id: number) {
    return await this.findOneBy({ _id: id });
  }
}
