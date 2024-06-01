import { Module } from '@nestjs/common';
import { PhotosService } from './photos.service';
import { AwsS3Provider } from './aws-sdk.provider';

@Module({
  providers: [PhotosService, AwsS3Provider],
  exports: [PhotosService],
})
export class PhotosModule {}
