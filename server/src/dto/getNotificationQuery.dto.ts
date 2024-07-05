import { Type } from 'class-transformer';
import { IsInt, IsOptional, IsString } from 'class-validator';

export class getNotificationQueryDto {
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  page?: number = 1;

  @IsOptional()
  @Type(() => Number)
  @IsInt()
  size?: number = 10;
}
