import {
  Body,
  Controller,
  Get,
  Param,
  Patch,
  UploadedFile,
  UseInterceptors,
} from '@nestjs/common';
import { Users } from './users.entity';
import { UsersService } from './users.service';
import { StandardResponseDto } from 'src/dto/standard-response.dto';
import { FileInterceptor } from '@nestjs/platform-express';
import ApiCodes from 'src/common/api.codes';
import ApiMessages from 'src/common/api.messages';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}
  @Patch(':id/init')
  @UseInterceptors(
    //사진저장 미들웨어
    FileInterceptor('petimg', {
      limits: { fileSize: 10 * 1024 * 1024 }, // 파일 사이즈 제한을 설정합니다. 여기선 10MB)
    }),
  )
  async initUser(
    @UploadedFile() file: Express.Multer.File,
    @Param('id') id: number,
    @Body() updatedUser: Partial<Users>,
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.usersService.initUser(id, updatedUser, file);
      response = new StandardResponseDto(ApiCodes.OK, ApiMessages.OK, result);
    } catch (error) {
      response = new StandardResponseDto(
        error.response.statusCode,
        error.response.message,
        null,
      );
    }
    return response;
  }
  @Get(':id')
  async findUser(@Param('id') id: number): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.usersService.findUserById(id);
      response = new StandardResponseDto(ApiCodes.OK, ApiMessages.OK, result);
    } catch (error) {
      response = new StandardResponseDto(
        error.response.statusCode,
        error.response.message,
        null,
      );
    }
    return response;
  }
}
