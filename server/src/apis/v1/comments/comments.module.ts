import { Module } from '@nestjs/common';
import { CommentsController } from './comments.controller';
import { CommentsService } from './comments.service';
import { CommentRepository } from './comments.repository';
import { UsersModule } from '../users/users.module';
import { ArticlesModule } from '../articles/articles.module';

@Module({
  controllers: [CommentsController],
  providers: [CommentsService, CommentRepository],
  imports: [UsersModule, ArticlesModule],
})
export class CommentsModule {}
