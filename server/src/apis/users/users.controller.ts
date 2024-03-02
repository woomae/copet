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
import { diskStorage } from 'multer';

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
      storage: diskStorage({
        destination: './uploads', // 파일 저장 경로를 지정합니다.
        filename: (req, file, callback) => {
          const filename = `${Date.now()}-${file.originalname}`;
          callback(null, filename);
        },
      }),
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
    return new StandardResponseDto(201, 'api.common.created', result);
  }
  @Get(':id')
  async findUser(@Param('id') id: number): Promise<StandardResponseDto> {
    const result = await this.usersService.findUserById(id);
    if (!result)
      return new StandardResponseDto(400, 'bad request', 'Invalid ID');
    return new StandardResponseDto(200, 'api.common.ok', result);
  }
}
