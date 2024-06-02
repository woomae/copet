import { IsEmail, IsNotEmpty, IsString } from 'class-validator';

//callback-user.dto.ts
export class CallBackUserDataDto {
  @IsString()
  @IsNotEmpty()
  provider_id: string;

  @IsEmail()
  email: string;
}
