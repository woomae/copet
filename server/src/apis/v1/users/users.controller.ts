import {
  Body,
  Controller,
  Get,
  Param,
  Patch,
  Req,
  UploadedFiles,
  UseGuards,
  UseInterceptors,
} from '@nestjs/common';
import { UsersService } from './users.service';
import { Request } from 'express';
import { FileFieldsInterceptor } from '@nestjs/platform-express';
import { UpdateUserDto } from 'src/dto/update-user.to';
import { JwtAuthGuard } from '../auth/jwt/jwt.guard';
import { Payload } from '../auth/jwt/jwt.payload';

@Controller({ path: 'users', version: '1' })
export class UsersController {
  constructor(private readonly usersService: UsersService) {}
  @UseGuards(JwtAuthGuard)
  @Patch('')
  @UseInterceptors(
    FileFieldsInterceptor([{ name: 'petimg', maxCount: 1 }], {
      limits: { fileSize: 10 * 1024 * 1024 },
    }),
  )
  async initUser(
    @Req() req: Request,
    @UploadedFiles() file: { petimg: Express.Multer.File[] },
    @Body() updateUserDto: UpdateUserDto,
  ) {
    const userPayload = req.user as Payload;
    const result = await this.usersService.initUser(
      userPayload.user_id,
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
}
