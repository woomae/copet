import { Module } from '@nestjs/common';
import { ArticlesController } from './articles.controller';
import { ArticlesService } from './articles.service';
import { ArticleRepository } from './articles.repository';
import { UsersModule } from '../users/users.module';
import { PhotosModule } from '../photos/photos.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Photos } from '../photos/photos.entity';

@Module({
  controllers: [ArticlesController],
  providers: [ArticlesService, ArticleRepository],
  exports: [ArticlesService],
  imports: [UsersModule, PhotosModule, TypeOrmModule.forFeature([Photos])],
})
export class ArticlesModule {}
