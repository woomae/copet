import { Module } from '@nestjs/common';
import { ArticlesController } from './articles.controller';
import { ArticlesService } from './articles.service';
import { ArticleRepository } from './articles.repository';
import { UsersModule } from '../users/users.module';

@Module({
  controllers: [ArticlesController],
  providers: [ArticlesService, ArticleRepository],
  exports: [ArticlesService],
  imports: [UsersModule],
})
export class ArticlesModule {}
