import {
  Body,
  Controller,
  Get,
  Param,
  Patch,
  UploadedFiles,
  UseInterceptors,
} from '@nestjs/common';
import { Users } from './users.entity';
import { UsersService } from './users.service';
import { StandardResponseDto } from 'src/dto/standard-response.dto';
import { FileFieldsInterceptor } from '@nestjs/platform-express';
import ResponseFormat from 'src/common/response-format';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}
  @Patch(':id/init')
  @UseInterceptors(
    FileFieldsInterceptor([{ name: 'petimg', maxCount: 1 }], {
      limits: { fileSize: 10 * 1024 * 1024 },
    }),
    //사진용량 구성 필요
  )
  async initUser(
    @UploadedFiles() files: { petimg: Express.Multer.File[] },
    @Param('id') id: number,
    @Body() updatedUser: Partial<Users>,
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.usersService.initUser(
        id,
        updatedUser,
        files?.petimg[0],
      );
      response = ResponseFormat.ok(result).format();
    } catch (error) {
      response = ResponseFormat.fail(error).format();
    }
    return response;
  }
  @Get(':id')
  async findUser(@Param('id') id: number): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.usersService.findUserById(id);
      response = ResponseFormat.ok(result).format();
    } catch (error) {
      response = ResponseFormat.fail(error).format();
    }
    return response;
  }
}
