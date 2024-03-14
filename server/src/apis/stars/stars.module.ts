import { Module } from '@nestjs/common';
import { StarsController } from './stars.controller';
import { StarsService } from './stars.service';
import { StarsRepository } from './stars.repository';
import { ArticlesModule } from '../articles/articles.module';
import { UsersModule } from '../users/users.module';

@Module({
  controllers: [StarsController],
  providers: [StarsService, StarsRepository],
  imports: [ArticlesModule, UsersModule],
})
export class StarsModule {}
