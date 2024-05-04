import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as cookieParser from 'cookie-parser';
import { ConfigService } from '@nestjs/config';
import { winstonLogger } from './common/logger/winston.util';

async function bootstrap() {
  const app = await NestFactory.create(AppModule, { logger: winstonLogger });

  const configservice = app.get(ConfigService);
  const port = configservice.get('APP_PORT');

  app.enableCors({ origin: '*', credentials: true }); // CORS 허용
  app.use(cookieParser()); // cookieParser 사용

  await app.listen(port);
}
bootstrap();
