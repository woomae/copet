import { IsNumber, IsString } from 'class-validator';

// Create-comment.dto
export class CreateCommentDto {
  @IsNumber()
  owner_id: number;

  @IsNumber()
  article_id: number;

  @IsString()
  comment: string;

  @IsString()
  nickname: string;
}
