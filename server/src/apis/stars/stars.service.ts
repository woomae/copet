import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { StarsRepository } from './stars.repository';
import { Stars } from './stars.entity';
import { ArticlesService } from '../articles/articles.service';
import { UsersService } from '../users/users.service';

@Injectable()
export class StarsService {
  constructor(
    @InjectRepository(StarsRepository)
    private starsRepository: StarsRepository,
    private articlesService: ArticlesService,
    private usersService: UsersService,
  ) {}
  async getAllStar(bodyData: Partial<Stars>) {
    const userChecker = await this.usersService.findUserById(
      bodyData.clicked_user_id,
    );
    if (!userChecker) {
      throw new BadRequestException('clicked_user_id is not exist');
    }
    return await this.starsRepository.getAllStar(bodyData.clicked_user_id);
  }
  async likeRequest(bodyData: Partial<Stars>): Promise<Stars> {
    //없는 article_id인지 확인
    if (await this.articlesService.getArticleById(bodyData.article_id))
      throw new BadRequestException('article_id is not exist');
    //이미 좋아요인지 확인 후 좋아요를 누르거나 취소
    if (await this.starsRepository.likeChecker(bodyData)) {
      //article, scrap_count 감소
      await this.articlesService.decreaseScrapCount(bodyData.article_id);
      await this.starsRepository.deleteLikeRequest(bodyData);
      return null;
    }
    //article, scrap_count 증가
    await this.articlesService.increaseScrapCount(bodyData.article_id);
    return await this.starsRepository.createLikeRequest(bodyData);
  }
}
