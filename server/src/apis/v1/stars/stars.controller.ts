import { Get, Controller, Post, Body } from '@nestjs/common';
import { StarsService } from './stars.service';
import { Stars } from './stars.entity';

@Controller('stars')
export class StarsController {
  constructor(private readonly starsService: StarsService) {}
  @Get('')
  async getAllStar(@Body() bodyData: Partial<Stars>) {
    const result = await this.starsService.getAllStar(bodyData);
    return result;
  }
  @Post('like-request')
  async likeRequest(@Body() bodyData: Partial<Stars>) {
    const result = await this.starsService.likeRequest(bodyData);
    return result;
  }
}
