import { Injectable } from '@nestjs/common';
import { Articles } from './articles.entity';
import { DataSource, Like, Repository } from 'typeorm';

@Injectable()
export class ArticleRepository extends Repository<Articles> {
  constructor(dataSource: DataSource) {
    super(Articles, dataSource.createEntityManager());
  }
  async getArticleById(_id: number) {
    return await this.findOneBy({ _id: _id });
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

  async updateArticle(id: number, bodyData: any): Promise<Articles> {
    await this.update({ _id: id }, bodyData);
    return await this.findOneBy({ _id: id });
  }
  async ownerChecker(_id: number, owner_id: number): Promise<boolean> {
    const result = await this.createQueryBuilder('articles')
      .leftJoinAndSelect('articles.owner_id', 'user')
      .where('articles._id = :_id', { _id: _id })
      .andWhere('user._id = :owner_id', { owner_id: owner_id })
      .getOne();
    if (result) {
      return false;
    } else {
      return true;
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
  async increaseCommentCount(id: number): Promise<void> {
    await this.increment({ _id: id }, 'comment_count', 1);
  }
  async decreaseCommentCount(id: number): Promise<void> {
    await this.decrement({ _id: id }, 'comment_count', 1);
  }
  async searchArticles(q: string, page: number, size: number) {
    const [comments, total] = await this.findAndCount({
      where: [{ title: Like(`%${q}%`) }, { body: Like(`%${q}%`) }],
      take: size,
      skip: (page - 1) * size,
    });

    const commentsData = {
      total,
      comments,
    };
    return commentsData;
  }
}
