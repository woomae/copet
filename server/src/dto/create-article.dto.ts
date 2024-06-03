import { IsString } from 'class-validator';

// create-article.dto
export class CreateArticleDto {
  @IsString()
  title: string;

  @IsString()
  body: string;

  @IsString()
  category: string;
}
