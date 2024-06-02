//create-photo.dto

import { Type } from 'class-transformer';
import { IsArray, IsString, ValidateNested } from 'class-validator';
import { Articles } from 'src/apis/v1/articles/articles.entity';
import { Users } from 'src/apis/v1/users/users.entity';

export class CreatePhotoDto {
  @IsString()
  img_path: string;

  @ValidateNested()
  @Type(() => Users)
  user?: Users;

  @ValidateNested()
  @Type(() => Articles)
  article?: Articles;
}
