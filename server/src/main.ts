import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as cookieParser from 'cookie-parser';
import { ConfigService } from '@nestjs/config';
import { WinstonModule, utilities } from 'nest-winston';
import * as winston from 'winston';

async function bootstrap() {
  const app = await NestFactory.create(AppModule, {
    logger: WinstonModule.createLogger({
      transports: [
        new winston.transports.Console({
          format: winston.format.combine(
            winston.format.timestamp(),
            winston.format.ms(),
            utilities.format.nestLike('Copet', {
              prettyPrint: true,
            }),
            winston.format.printf(({ level, message, timestamp }) => {
              return `${timestamp} ${level}: ${message}`;
            }),
          ),
        }),
      ],
    }),
  });

  const configservice = app.get(ConfigService);
  const port = configservice.get('APP_PORT');

  app.enableCors({ origin: '*', credentials: true }); // CORS 허용
  app.use(cookieParser()); // cookieParser 사용

  await app.listen(port);
}
bootstrap();
