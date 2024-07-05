import { Get, Controller, Post, Body, UseGuards } from '@nestjs/common';
import { StarsService } from './stars.service';
import { Request } from 'express';
import { Req } from '@nestjs/common';
import { Payload } from '../auth/jwt/jwt.payload';
import { JwtAuthGuard } from '../auth/jwt/jwt.guard';
import { StarRequestDto } from 'src/dto/star-request.dto';
import { User } from 'src/common/decorators/user.decorator';

@UseGuards(JwtAuthGuard)
@Controller({ path: 'stars', version: '1' })
export class StarsController {
  constructor(private readonly starsService: StarsService) {}
  @Get('')
  async getAllStar(@User() user: Payload) {
    const result = await this.starsService.getAllStar(user.user_id);
    return result;
  }
  @Post('like-request')
  async likeRequest(
    @User() user: Payload,
    @Body() starRequestDto: StarRequestDto,
  ) {
    const result = await this.starsService.likeRequest(
      user.user_id,
      starRequestDto.article_id,
    );
    return result;
  }
}
