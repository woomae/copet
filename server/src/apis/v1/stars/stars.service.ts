import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { StarsRepository } from './stars.repository';
import { Stars } from './stars.entity';
import { ArticlesService } from '../articles/articles.service';
import ApiError from 'src/libs/res/api.errors';
import ApiCodes from 'src/libs/res/api.codes';
import ApiMessages from 'src/libs/res/api.messages';
import { NotificationsService } from '../notifications/notifications.service';
import { starPayloads } from 'src/libs/notifications/payloads/starPayloads';

@Injectable()
export class StarsService {
  constructor(
    @InjectRepository(StarsRepository)
    private starsRepository: StarsRepository,
    private articlesService: ArticlesService,
    private notificationsService: NotificationsService,
  ) {}
  async getAllStar(id: number): Promise<Stars[]> {
    return await this.starsRepository.getAllStar(id);
  }
  async likeRequest(id: number, article_id: number): Promise<Stars> {
    const articleData = await this.articlesService.getArticleById(article_id);
    //없는 article_id인지 확인
    if (!articleData)
      throw new ApiError(ApiCodes.NOT_FOUND, ApiMessages.NOT_FOUND, {
        message: 'article_id not found',
      });
    //이미 좋아요인지 확인 후 좋아요를 누르거나 취소
    if (await this.starsRepository.likeChecker(id, article_id)) {
      //article, scrap_count 감소
      await this.articlesService.decreaseScrapCount(article_id);
      await this.starsRepository.deleteLikeRequest(id, article_id);
      return null;
    }
    //article, scrap_count 증가
    await this.articlesService.increaseScrapCount(article_id);
    const starData = new Stars();
    starData.clicked_user_id = id;
    starData.article_id = article_id;
    const result = await this.starsRepository.createLikeRequest(starData);
    //알림 전송
    await this.notificationsService.sendNotification(
      articleData.owner_id,
      id,
      starPayloads,
    );
    return result;
  }
}
