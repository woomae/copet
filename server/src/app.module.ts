import { Module } from '@nestjs/common';
import { UsersModule } from './apis/users/users.module';
import { ArticlesModule } from './apis/articles/articles.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { typeORMConfig } from './configs/typeorm.config';
import { AuthModule } from './apis/auth/auth.module';

@Module({
  imports: [
    AuthModule,
    ArticlesModule,
    UsersModule,
    TypeOrmModule.forRoot(typeORMConfig),
  ],
})
export class AppModule {}
