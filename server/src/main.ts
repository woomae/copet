import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as cookieParser from 'cookie-parser';
import { ConfigService } from '@nestjs/config';
import { winstonLogger } from './libs/logger/winston.util';
import * as bodyParser from 'body-parser';
import { VersioningType } from '@nestjs/common';

async function bootstrap() {
  const app = await NestFactory.create(AppModule, { logger: winstonLogger });

  app.enableVersioning({
    type: VersioningType.URI,
  });
  const env = app.get(ConfigService);
  const port = env.get('APP_PORT');

  app.enableCors({ origin: '*', credentials: true }); // CORS 허용
  app.use(cookieParser()); // cookieParser 사용

  // 최대 요청 본문 크기 설정
  app.use(bodyParser.json({ limit: '25mb' }));
  app.use(bodyParser.urlencoded({ limit: '25mb', extended: true }));

  await app.listen(port);
}
bootstrap();
