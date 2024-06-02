import { Transform } from 'class-transformer';
import { IsArray, IsString } from 'class-validator';
import { Photos } from 'src/apis/v1/photos/photos.entity';

// create-article.dto
export class CreateArticleDto {
  @IsString()
  title: string;

  @IsString()
  body: string;

  @IsString()
  category: string;

  @IsString()
  author?: string;

  @IsArray()
  @IsString({ each: true })
  @Transform(({ value }) => JSON.parse(value))
  img_urls?: Photos[];
}
