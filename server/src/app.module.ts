import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { UsersModule } from './apis/users/users.module';
import { ArticlesModule } from './apis/articles/articles.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { getTypeOrmConfig } from './configs/typeorm.config';
import { AuthModule } from './apis/auth/auth.module';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { validate } from './configs/env-validation';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { FriendsModule } from './apis/friends/friends.module';
import { StarsModule } from './apis/stars/stars.module';
import { CommentsModule } from './apis/comments/comments.module';
import { LoggingInterceptor } from './common/logger/logger.intrecepter';
import { MocksModule } from './apis/mocks/mocks.module';
import { RanksModule } from './apis/ranks/ranks.module';
import { RedisModule, RedisModuleOptions } from '@nestjs-modules/ioredis';
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
    AuthModule,
    ArticlesModule,
    UsersModule,
    FriendsModule,
    StarsModule,
    CommentsModule,
    MocksModule,
    RanksModule,
  ],
  controllers: [AppController],
  providers: [AppService, LoggingInterceptor],
})
export class AppModule {}
