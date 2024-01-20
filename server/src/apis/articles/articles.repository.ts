import { Injectable } from '@nestjs/common';
import { Articles } from './articles.entity';
import { DataSource, Repository } from 'typeorm';

@Injectable()
export class ArticleRepository extends Repository<Articles> {
  constructor(dataSource: DataSource) {
    super(Articles, dataSource.createEntityManager());
  }
  async getArticleById(id: number) {
    return await this.findOneBy({ _id: id });
  }
}
