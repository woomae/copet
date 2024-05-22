import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { getTypeOrmConfig } from './configs/typeorm.config';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { validate } from './configs/env-validation';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { RedisModule, RedisModuleOptions } from '@nestjs-modules/ioredis';
import { V1Module } from './apis/v1/v1.module';
import { APP_FILTER, APP_INTERCEPTOR } from '@nestjs/core';
import { ResponseInterceptor } from './libs/res/response.intercepter';
import { ContextMiddleware } from './libs/middleware/request-context/context.middleware';
import { AllExceptionsFilter } from './libs/filters/http-exception.filter';
@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: `.env.${process.env.NODE_ENV}`,
      validate,
    }),
    TypeOrmModule.forRootAsync({
      useFactory: async () => await getTypeOrmConfig(),
    }),
    RedisModule.forRootAsync({
      inject: [ConfigService], // ConfigService 주입
      useFactory: async (
        configService: ConfigService,
      ): Promise<RedisModuleOptions> => ({
        options: {
          host: configService.get('REDIS_HOST'),
          port: configService.get('REDIS_PORT'),
          password: configService.get('REDIS_PASSWORD'),
        },
        type: 'single',
      }),
    }),
    V1Module,
  ],
  controllers: [AppController],
  providers: [
    AppService,
    {
      provide: APP_INTERCEPTOR,
      useClass: ResponseInterceptor,
    },
    {
      provide: APP_FILTER,
      useClass: AllExceptionsFilter,
    },
  ],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(ContextMiddleware).forRoutes('*');
  }
}
