import { Injectable } from '@nestjs/common';
import { Stars } from './stars.entity';
import { DataSource, Repository } from 'typeorm';

@Injectable()
export class StarsRepository extends Repository<Stars> {
  constructor(dataSource: DataSource) {
    super(Stars, dataSource.createEntityManager());
  }
  async getAllStar(id: number) {
    return await this.findBy({ clicked_user_id: id });
  }
  async createLikeRequest(starData: Partial<Stars>): Promise<Stars> {
    return await this.save(starData);
  }
  async deleteLikeRequest(id: number, article_id: number): Promise<any> {
    const result = await this.createQueryBuilder('stars')
      .leftJoinAndSelect('stars.clicked_user_id', 'users')
      .where('stars.article_id = :article_id', {
        article_id: article_id,
      })
      .andWhere('stars.clicked_user_id = :clicked_user_id', {
        clicked_user_id: id,
      })
      .getOne();
    return await this.delete({ _id: result._id });
  }
  async likeChecker(id: number, article_id: number): Promise<boolean> {
    const result = await this.createQueryBuilder('stars')
      .leftJoinAndSelect('stars.clicked_user_id', 'users')
      .where('stars.article_id = :article_id', {
        article_id: article_id,
      })
      .andWhere('stars.clicked_user_id = :clicked_user_id', {
        clicked_user_id: id,
      })
      .getOne();
    if (result) {
      return true;
    } else {
      return false;
    }
  }
}
