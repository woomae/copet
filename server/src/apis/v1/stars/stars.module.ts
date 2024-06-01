import { Module } from '@nestjs/common';
import { StarsController } from './stars.controller';
import { StarsService } from './stars.service';
import { StarsRepository } from './stars.repository';
import { ArticlesModule } from '../articles/articles.module';

@Module({
  controllers: [StarsController],
  providers: [StarsService, StarsRepository],
  imports: [ArticlesModule],
})
export class StarsModule {}
