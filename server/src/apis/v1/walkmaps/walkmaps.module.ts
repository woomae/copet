import { Module } from '@nestjs/common';
import { WalkmapsController } from './walkmaps.controller';
import { WalkmapsService } from './walkmaps.service';
import { PhotosModule } from '../photos/photos.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Photos } from '../photos/photos.entity';
import { WalkmapsRepository } from './walkmaps.repository';

@Module({
  controllers: [WalkmapsController],
  providers: [WalkmapsService, WalkmapsRepository],
  imports: [PhotosModule, TypeOrmModule.forFeature([Photos])],
})
export class WalkmapsModule {}
