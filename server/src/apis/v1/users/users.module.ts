import { Module } from '@nestjs/common';
import { UsersController } from './users.controller';
import { UsersService } from './users.service';
import { UsersRepository } from './users.repository';
import { PhotosModule } from '../photos/photos.module';
import { PetKeywords } from '../petkeywords/petkeywords.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Photos } from '../photos/photos.entity';

@Module({
  controllers: [UsersController],
  providers: [UsersService, UsersRepository],
  exports: [UsersService],
  imports: [
    PhotosModule,
    TypeOrmModule.forFeature([PetKeywords]),
    TypeOrmModule.forFeature([Photos]),
  ],
})
export class UsersModule {}
