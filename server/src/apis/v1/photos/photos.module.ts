import { Module } from '@nestjs/common';
import { PhotosService } from './photos.service';
import { AwsS3Provider } from './aws-sdk.provider';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Photos } from './photos.entity';

@Module({
  providers: [PhotosService, AwsS3Provider],
  exports: [PhotosService],
  imports: [TypeOrmModule.forFeature([Photos])],
})
export class PhotosModule {}
