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
  async getAllArticles(page: number, size: number) {
    const [comments, total] = await this.findAndCount({
      take: size,
      skip: (page - 1) * size,
    });

    const commentsData = {
      total,
      comments,
    };
    return commentsData;
  }
  async createArticle(bodyData: any) {
    return await this.save(bodyData);
  }
}
