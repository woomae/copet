import { Module } from '@nestjs/common';
import { RanksController } from './ranks.controller';
import { RanksService } from './ranks.service';

@Module({
  controllers: [RanksController],
  providers: [RanksService],
})
export class RanksModule {}
