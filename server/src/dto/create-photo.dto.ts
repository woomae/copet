//create-photo.dto

import { Type } from 'class-transformer';
import { IsArray, IsOptional, IsString, ValidateNested } from 'class-validator';
import { Articles } from 'src/apis/v1/articles/articles.entity';
import { Users } from 'src/apis/v1/users/users.entity';

export class CreatePhotoDto {
  @IsString()
  img_path: string;

  @IsOptional()
  @ValidateNested()
  @Type(() => Users)
  user?: Users;

  @IsOptional()
  @ValidateNested()
  @Type(() => Articles)
  article?: Articles;
}
