import { Module } from '@nestjs/common';
import { ArticlesController } from './articles.controller';
import { ArticlesService } from './articles.service';
import { ArticleRepository } from './article.repository';

@Module({
  controllers: [ArticlesController],
  providers: [ArticlesService, ArticleRepository],
})
export class ArticlesModule {}
