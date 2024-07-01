import { IsNumber, IsOptional, IsString } from 'class-validator';

// Create-comment.dto
export class CreateCommentDto {
  @IsNumber()
  article_id: number;

  @IsString()
  comment: string;

  @IsOptional()
  @IsString()
  nickname?: string;

  @IsOptional()
  @IsNumber()
  owner_id?: number;
}
