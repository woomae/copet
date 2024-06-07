import { Injectable } from '@nestjs/common';
import { Articles } from './articles.entity';
import { DataSource, Like, Repository } from 'typeorm';

@Injectable()
export class ArticleRepository extends Repository<Articles> {
  constructor(dataSource: DataSource) {
    super(Articles, dataSource.createEntityManager());
  }
  async getArticleByIdWithPhotos(_id: number) {
    const queryBuilder = this.createQueryBuilder('article')
      .leftJoinAndSelect('article.photos', 'photo')
      .where('article._id = :_id', { _id: _id });
    const article = await queryBuilder.getOne();
    const articleData = {
      ...article,
      photos: article.photos.map((photo) => photo.img_path),
    };
    return articleData;
  }
  async getAllArticlesByCategory(page: number, size: number, category: string) {
    const queryBuilder = this.createQueryBuilder('article')
      .where({ category: category })
      .take(size)
      .skip((page - 1) * size);
    const [articles, total] = await queryBuilder.getManyAndCount();
    // 각 article에서 첫 번째 사진만 포함시키도록 데이터 변환합니다.
    const articlesData = articles.map((article) => ({
      ...article,
      photos: article.photos.map((photo) => photo.img_path), // 포토 객체의 img_path만 포함
    }));

    return {
      total,
      articles: articlesData,
    };
  }
  async getAllArticles(page: number, size: number) {
    const queryBuilder = this.createQueryBuilder('article')
      .leftJoinAndSelect('article.photos', 'photo')
      .take(size)
      .skip((page - 1) * size);
    const [articles, total] = await queryBuilder.getManyAndCount();
    // 각 article에서 첫 번째 사진만 포함시키도록 데이터 변환합니다.
    const articlesData = articles.map((article) => ({
      ...article,
      photos: article.photos.map((photo) => photo.img_path), // 포토 객체의 img_path만 포함
    }));

    return {
      total,
      articles: articlesData,
    };
  }
  async getAllArticleByOwner(owner_id: number) {
    return await this.createQueryBuilder('articles')
      .leftJoin('articles.owner_id', 'user')
      .where('articles.owner_id = :owner_id', { owner_id: owner_id })
      .getMany();
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
    const queryBuilder = this.createQueryBuilder('article')
      .leftJoinAndSelect('article.photos', 'photo')
      .where('article.title LIKE :q OR article.body LIKE :q', { q: `%${q}%` })
      .take(size)
      .skip((page - 1) * size);
    const [articles, total] = await queryBuilder.getManyAndCount();
    const articlesData = articles.map((article) => ({
      ...article,
      photos: article.photos.map((photo) => photo.img_path), // 포토 객체의 img_path만 포함
    }));

    return {
      total,
      articles: articlesData,
    };
  }
}
