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

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}
  @Get('/')
  async getAllUsers(): Promise<Users[]> {
    return this.usersService.findAll(); //수정 필요 보안적으로 위험 및 필요없음(테스트용)
  }
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
    const result = await this.usersService.initUser(id, updatedUser, file);
    if (!result)
      return new StandardResponseDto(400, 'bad request', 'can not init user');
    return new StandardResponseDto(200, 'api.common.ok', result);
  }
  @Get(':id')
  async findUser(@Param('id') id: number): Promise<StandardResponseDto> {
    const result = await this.usersService.findUserById(id);
    if (!result)
      return new StandardResponseDto(400, 'bad request', 'Invalid ID');
    return new StandardResponseDto(200, 'api.common.ok', result);
  }
}
