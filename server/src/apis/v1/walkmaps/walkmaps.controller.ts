import {
  Body,
  Controller,
  Get,
  Post,
  UploadedFiles,
  UseGuards,
  UseInterceptors,
} from '@nestjs/common';
import { WalkmapsService } from './walkmaps.service';
import { JwtAuthGuard } from '../auth/jwt/jwt.guard';
import { FileFieldsInterceptor } from '@nestjs/platform-express';
import { memoryStorage } from 'multer';
import { User } from 'src/common/decorators/user.decorator';
import { Payload } from '../auth/jwt/jwt.payload';
import { CreateWalkmapDto } from 'src/dto/create-walkmap.dto';

@Controller({ path: 'walkmaps', version: '1' })
export class WalkmapsController {
  constructor(private readonly walkmapsService: WalkmapsService) {}
  @UseGuards(JwtAuthGuard)
  @Post('')
  @UseInterceptors(
    FileFieldsInterceptor([{ name: 'mapimg', maxCount: 1 }], {
      storage: memoryStorage(),
      limits: { fileSize: 10 * 1024 * 1024 },
    }),
  )
  async createWalkmap(
    @User() user: Payload,
    @UploadedFiles() file: { mapimg: Express.Multer.File[] },
    @Body() createWalkmapDto: CreateWalkmapDto,
  ) {
    const result = await this.walkmapsService.createWalkmap(
      user.user_id,
      createWalkmapDto,
      file,
    );
    return result;
  }
  @UseGuards(JwtAuthGuard)
  @Get('')
  async getWalkmaps(@User() user: Payload) {
    const result = await this.walkmapsService.getWalkmaps(user.user_id);
    return result;
  }
}
