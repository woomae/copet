import { Type } from 'class-transformer';
import { IsInt, IsOptional, IsString } from 'class-validator';

export class getArticleQueryDto {
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  page?: number = 0;

  @IsOptional()
  @Type(() => Number)
  @IsInt()
  size?: number = 10;

  @IsOptional()
  @Type(() => Number)
  @IsInt()
  owner?: number;

  @IsOptional()
  @Type(() => String)
  @IsString()
  q?: string;

  @IsOptional()
  @Type(() => String)
  @IsString()
  category?: string;
}
