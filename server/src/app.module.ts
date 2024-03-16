import { Module } from '@nestjs/common';
import { UsersModule } from './apis/users/users.module';
import { ArticlesModule } from './apis/articles/articles.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { getTypeOrmConfig } from './configs/typeorm.config';
import { AuthModule } from './apis/auth/auth.module';
import { ConfigModule } from '@nestjs/config';
import { validate } from './configs/env-validation';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { FriendsModule } from './apis/friends/friends.module';
import { StarsModule } from './apis/stars/stars.module';
import { CommentsModule } from './apis/comments/comments.module';

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
    AuthModule,
    ArticlesModule,
    UsersModule,
    FriendsModule,
    StarsModule,
    CommentsModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
