import { Injectable } from '@nestjs/common';
import { Stars } from './stars.entity';
import { DataSource, Repository } from 'typeorm';

@Injectable()
export class StarsRepository extends Repository<Stars> {
  constructor(dataSource: DataSource) {
    super(Stars, dataSource.createEntityManager());
  }
  async getAllStar(clicked_user_id: number) {
    return await this.findBy({ clicked_user_id: clicked_user_id });
  }
  async createLikeRequest(bodyData: any): Promise<Stars> {
    return await this.save(bodyData);
  }
  async deleteLikeRequest(bodyData: any): Promise<any> {
    const result = await this.createQueryBuilder('stars')
      .leftJoinAndSelect('stars.clicked_user_id', 'users')
      .where('stars.article_id = :article_id', {
        article_id: bodyData.article_id,
      })
      .andWhere('stars.clicked_user_id = :clicked_user_id', {
        clicked_user_id: bodyData.clicked_user_id,
      })
      .getOne();
    return await this.delete({ _id: result._id });
  }
  async likeChecker(bodyData: Partial<Stars>): Promise<boolean> {
    const result = await this.createQueryBuilder('stars')
      .leftJoinAndSelect('stars.clicked_user_id', 'users')
      .where('stars.article_id = :article_id', {
        article_id: bodyData.article_id,
      })
      .andWhere('stars.clicked_user_id = :clicked_user_id', {
        clicked_user_id: bodyData.clicked_user_id,
      })
      .getOne();
    if (result) {
      return true;
    } else {
      return false;
    }
  }
}
