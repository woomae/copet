import { Get, Controller, Post, Body, UseGuards } from '@nestjs/common';
import { StarsService } from './stars.service';
import { Request } from 'express';
import { Req } from '@nestjs/common';
import { Payload } from '../auth/jwt/jwt.payload';
import { JwtAuthGuard } from '../auth/jwt/jwt.guard';
import { StarRequestDto } from 'src/dto/star-request.dto';

@UseGuards(JwtAuthGuard)
@Controller({ path: 'stars', version: '1' })
export class StarsController {
  constructor(private readonly starsService: StarsService) {}
  @Get('')
  async getAllStar(@Req() req: Request) {
    const userPayload = req.user as Payload;
    const result = await this.starsService.getAllStar(userPayload.user_id);
    return result;
  }
  @Post('like-request')
  async likeRequest(
    @Req() req: Request,
    @Body() starRequestDto: StarRequestDto,
  ) {
    const userPayload = req.user as Payload;
    const result = await this.starsService.likeRequest(
      userPayload.user_id,
      starRequestDto.article_id,
    );
    return result;
  }
}
