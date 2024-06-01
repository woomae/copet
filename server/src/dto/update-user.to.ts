import { IsString } from 'class-validator';

// update-user.dto
export class UpdateUserDto {
  @IsString()
  nickname: string;

  @IsString()
  pet_catagory: string;

  @IsString()
  region: string;

  @IsString()
  petkeyword: string[];

  @IsString()
  intro?: string;

  @IsString()
  petimg?: string;
}
