import { IsNumber } from 'class-validator';

// star-request.dto
export class StarRequestDto {
  @IsNumber()
  article_id: number;
}
