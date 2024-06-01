import { BadRequestException, Inject, Injectable } from '@nestjs/common';
import * as AWS from 'aws-sdk';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class PhotosService {
  constructor(
    private readonly env: ConfigService,
    @Inject('AWS_S3') private readonly awsS3: AWS.S3,
  ) {}
  async uploadFiles(
    files: Express.Multer.File[],
    location: string,
  ): Promise<string[]> {
    const img_arr = [];
    for (const file of files) {
      try {
        //사진데이터 존재시 처리
        await this.awsS3
          .putObject({
            Bucket: this.env.get('AWS_S3_BUCKET') + location,
            Key: file.originalname,
            Body: file.buffer,
            ACL: 'public-read',
            ContentType: file.mimetype,
          })
          .promise();

        //이미지 경로 저장
        img_arr.push(
          `https://${
            this.env.get('AWS_S3_BUCKET') + location
          }.s3.${this.env.get('AWS_S3_REGION')}.amazonaws.com${location}/${
            file.originalname
          }`,
        );
      } catch (error) {
        throw new BadRequestException(`File upload failed : ${error}`);
      }
    }
    return img_arr;
  }
  async deleteFiles(articleData: string[], location: string) {
    for (const img of articleData) {
      await this.awsS3
        .deleteObject({
          Bucket: this.env.get('AWS_S3_BUCKET') + location,
          Key: img, //키 값은 버킷부터의 경로로 작성
        })
        .promise();
    }
  }
}
