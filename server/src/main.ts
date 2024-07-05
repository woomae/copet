import { NestFactory, Reflector } from '@nestjs/core';
import { AppModule } from './app.module';
import * as cookieParser from 'cookie-parser';
import { ConfigService } from '@nestjs/config';
import { winstonLogger } from './libs/logger/winston.util';
import * as httpContext from 'express-http-context';
import {
  ClassSerializerInterceptor,
  ValidationPipe,
  VersioningType,
} from '@nestjs/common';

async function bootstrap() {
  const app = await NestFactory.create(AppModule, { logger: winstonLogger });

  app.enableVersioning({
    type: VersioningType.URI,
  });
  const env = app.get(ConfigService);
  const port = env.get('APP_PORT');

  // CORS 허용
  const allowedOrigins = [
    'http://localhost:5200',
    'http://localhost:5300',
    'https://dev.copet.life',
    'https://copet.life',
    'https://www.copet.life',
  ];
  app.enableCors({
    origin: (origin, callback) => {
      if (!origin || allowedOrigins.includes(origin)) {
        callback(null, true);
      } else {
        callback(new Error('Not allowed by CORS'));
      }
    },
    credentials: true,
  });

  app.use(cookieParser()); // cookieParser 사용

  app.use(httpContext.middleware);
  app.useGlobalInterceptors(new ClassSerializerInterceptor(app.get(Reflector)));
  app.useGlobalPipes(
    new ValidationPipe({
      transform: true,
      whitelist: true,
      forbidNonWhitelisted: true,
    }),
  );
  //파비콘 요청무시
  app.use((req, res, next) => {
    if (req.path === '/favicon.ico') {
      res.status(204).end();
    } else {
      next();
    }
  });

  await app.listen(port);
}
bootstrap();
