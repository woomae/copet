import { Module } from '@nestjs/common';
import { UsersModule } from './apis/users/users.module';
import { ArticlesModule } from './apis/articles/articles.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { getTypeOrmConfig } from './configs/typeorm.config';
import { AuthModule } from './apis/auth/auth.module';
import { ConfigModule } from '@nestjs/config';
import { validate } from './configs/env-validation';

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
  ],
})
export class AppModule {}
