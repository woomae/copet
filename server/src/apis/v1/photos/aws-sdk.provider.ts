import { FactoryProvider } from '@nestjs/common';
import * as AWS from 'aws-sdk';

export const AwsS3Provider: FactoryProvider = {
  provide: 'AWS_S3',
  useFactory: (): AWS.S3 => {
    return new AWS.S3({
      accessKeyId: process.env.AWS_ACCESS_KEY_ID,
      secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
      region: process.env.AWS_S3_REGION,
    });
  },
};
