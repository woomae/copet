import { IsString } from 'class-validator';

// Update-comment.dto
export class UpdateCommentDto {
  @IsString()
  comment: string;
}
