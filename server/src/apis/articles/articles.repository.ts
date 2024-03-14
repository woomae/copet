import { Injectable } from '@nestjs/common';
import { Articles } from './articles.entity';
import { DataSource, Repository } from 'typeorm';

@Injectable()
export class ArticleRepository extends Repository<Articles> {
  constructor(dataSource: DataSource) {
    super(Articles, dataSource.createEntityManager());
  }
  async getArticleById(article_id: number) {
    return await this.findOneBy({ article_id: article_id });
  }
  async getAllArticlesByCategory(page: number, size: number, category: string) {
    const [comments, total] = await this.findAndCount({
      where: { category: category },
      take: size,
      skip: (page - 1) * size,
    });

    const commentsData = {
      total,
      comments,
    };
    return commentsData;
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
  async getAllArticleByOwner(owner_id: number) {
    return await this.createQueryBuilder('articles')
      .leftJoin('articles.owner_id', 'user')
      .where('articles.owner_id = :owner_id', { owner_id: owner_id })
      .getMany();
  }

  async createArticle(bodyData: any): Promise<void> {
    return await this.save(bodyData);
  }
  async updateArticle(id: number, bodyData: any): Promise<void> {
    await this.update({ _id: id }, bodyData);
  }
  async ownerChecker(article_id: number, owner_id: number): Promise<boolean> {
    const result = await this.createQueryBuilder('articles')
      .leftJoinAndSelect('articles.owner_id', 'user')
      .where('articles._id = :article_id', { article_id: article_id })
      .andWhere('user._id = :owner_id', { owner_id: owner_id })
      .getOne();
    if (result) {
      return true;
    } else {
      return false;
    }
  }
  async deleteArticle(id: number): Promise<void> {
    await this.delete({ _id: id });
  }
  async increaseScrapCount(id: number): Promise<void> {
    await this.increment({ _id: id }, 'scrap_count', 1);
  }
  async decreaseScrapCount(id: number): Promise<void> {
    await this.decrement({ _id: id }, 'scrap_count', 1);
  }
}
