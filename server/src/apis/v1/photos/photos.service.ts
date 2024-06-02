import { Inject, Injectable } from '@nestjs/common';
import * as AWS from 'aws-sdk';
import { ConfigService } from '@nestjs/config';
import { v4 as uuidv4 } from 'uuid';
import ApiError from 'src/libs/res/api.errors';
import ApiCodes from 'src/libs/res/api.codes';
import ApiMessages from 'src/libs/res/api.messages';

@Injectable()
export class PhotosService {
  constructor(
    private readonly env: ConfigService,
    @Inject('AWS_S3') private readonly awsS3: AWS.S3,
  ) {}
  private ensureArray<T>(item: T | T[]): T[] {
    return Array.isArray(item) ? item : [item];
  }
  async uploadFiles(
    files: Express.Multer.File[],
    location: string,
  ): Promise<string[]> {
    files = this.ensureArray(files);
    const uploadPromises = files.map((file) => this.uploadFile(file, location));
    return await Promise.all(uploadPromises);
  }
  private getFileUrl(fileName: string, location: string): string {
    return `https://${this.env.get('AWS_S3_BUCKET')}.s3.${this.env.get(
      'AWS_S3_REGION',
    )}.amazonaws.com${location}/${fileName}`;
  }
  private async uploadFile(
    file: Express.Multer.File,
    location: string,
  ): Promise<string> {
    const fileName = `${uuidv4()}-${file.originalname}`;
    const params = {
      Bucket: this.env.get('AWS_S3_BUCKET') + location,
      Key: fileName,
      Body: file.buffer,
      ACL: 'public-read',
      ContentType: file.mimetype,
    };
    try {
      await this.awsS3.putObject(params).promise();
      return this.getFileUrl(fileName, location);
    } catch (error) {
      throw new ApiError(
        ApiCodes.INTERNAL_SERVER_ERROR,
        ApiMessages.INTERNAL_SERVER_ERROR,
        {
          message: 'upload failed',
        },
      );
    }
  }
  async deleteFiles(
    fileUrls: string | string[],
    location: string,
  ): Promise<void[]> {
    fileUrls = this.ensureArray(fileUrls);
    const deletePromises = fileUrls.map((fileUrl) =>
      this.deleteFile(fileUrl, location),
    );
    return await Promise.all(deletePromises);
  }
  private async deleteFile(fileUrl: string, location: string): Promise<void> {
    const fileName = this.extractFileNameFromUrl(fileUrl);
    const params = {
      Bucket: this.env.get('AWS_S3_BUCKET') + location,
      Key: fileName,
    };

    try {
      await this.awsS3.deleteObject(params).promise();
    } catch (error) {
      throw new ApiError(
        ApiCodes.INTERNAL_SERVER_ERROR,
        ApiMessages.INTERNAL_SERVER_ERROR,
        {
          message: 'delete failed',
        },
      );
    }
  }

  private extractFileNameFromUrl(fileUrl: string): string {
    const url = new URL(fileUrl);
    const fileName = url.pathname.split('/').pop();
    return decodeURIComponent(fileName);
  }

  // async deleteFiles(articleData: string[], location: string) {
  //   for (const img of articleData) {
  //     await this.awsS3
  //       .deleteObject({
  //         Bucket: this.env.get('AWS_S3_BUCKET') + location,
  //         Key: img, //키 값은 버킷부터의 경로로 작성
  //       })
  //       .promise();
  //   }
  // }
}
