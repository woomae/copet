import { Transform } from 'class-transformer';
import { IsArray, IsObject, IsOptional, IsString } from 'class-validator';

// update-user.dto
export class UpdateUserDto {
  @IsString()
  nickname: string;

  @IsString()
  pet_catagory: string;

  @IsObject()
  region: {
    state: string;
    city: string;
    district: string;
  };

  @IsArray()
  @IsString({ each: true })
  @Transform(({ value }) => JSON.parse(value))
  petkeyword: string[];

  @IsOptional()
  @IsString()
  intro?: string;
}
