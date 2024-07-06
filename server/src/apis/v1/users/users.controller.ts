import {
  Body,
  Controller,
  Get,
  Param,
  Patch,
  Post,
  Req,
  UploadedFiles,
  UseGuards,
  UseInterceptors,
} from '@nestjs/common';
import { UsersService } from './users.service';
import { FileFieldsInterceptor } from '@nestjs/platform-express';
import { UpdateUserDto } from 'src/dto/update-user.dto';
import { JwtAuthGuard } from '../auth/jwt/jwt.guard';
import { Payload } from '../auth/jwt/jwt.payload';
import { User } from 'src/common/decorators/user.decorator';
import { memoryStorage } from 'multer';

@Controller({ path: 'users', version: '1' })
export class UsersController {
  constructor(private readonly usersService: UsersService) {}
  @UseGuards(JwtAuthGuard)
  @Patch('')
  @UseInterceptors(
    FileFieldsInterceptor([{ name: 'petimg', maxCount: 1 }], {
      storage: memoryStorage(),
      limits: { fileSize: 10 * 1024 * 1024 },
    }),
  )
  async initUser(
    @User() user: Payload,
    @UploadedFiles() file: { petimg: Express.Multer.File[] },
    @Body() updateUserDto: UpdateUserDto,
  ) {
    const result = await this.usersService.initUser(
      user.user_id,
      updateUserDto,
      file,
    );
    return result;
  }
  @Get(':id')
  async findUser(@Param('id') id: number) {
    const result = await this.usersService.findUserById(id);
    return result;
  }

  @UseGuards(JwtAuthGuard)
  @Post('save-token')
  async saveToken(@User() user: Payload, @Body() body: { token: string }) {
    const result = await this.usersService.saveToken(user.user_id, body.token);
    return result;
  }
}
