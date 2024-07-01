import { Transform } from 'class-transformer';
import { IsArray, IsOptional, IsString } from 'class-validator';

// create-article.dto
export class CreateArticleDto {
  @IsString()
  title: string;

  @IsString()
  body: string;

  @IsString()
  category: string;

  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  @Transform(({ value }) => JSON.parse(value))
  delete_img?: string[];
}
