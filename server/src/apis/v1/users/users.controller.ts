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
import { FileFieldsInterceptor } from '@nestjs/platform-express';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}
  @Patch(':id')
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
  ) {
    if (!files || !files.petimg || files.petimg.length === 0) {
      // 파일이 업로드되지 않았을 때 처리
      const result = await this.usersService.initUser(
        id,
        updatedUser,
        undefined,
      );
      return result;
    } else {
      const result = await this.usersService.initUser(
        id,
        updatedUser,
        files.petimg[0],
      );
      return result;
    }
  }
  @Get(':id')
  async findUser(@Param('id') id: number) {
    const result = await this.usersService.findUserById(id);
    return result;
  }
}
