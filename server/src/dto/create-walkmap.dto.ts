import { Transform, Type } from 'class-transformer';
import { IsDateString, IsInt, IsString } from 'class-validator';

// create-walkmap.dto
export class CreateWalkmapDto {
  @IsString()
  walk_started_at: string;

  @IsInt()
  @Type(() => Number)
  steps: number;

  @IsInt()
  @Type(() => Number)
  duration_seconds: number;
}
