import { Get, Controller, Post, Body } from '@nestjs/common';
import { StarsService } from './stars.service';
import { StandardResponseDto } from 'src/dto/standard-response.dto';
import { Stars } from './stars.entity';

@Controller('stars')
export class StarsController {
  constructor(private readonly starsService: StarsService) {}
  @Get('')
  async getAllStar(
    @Body() bodyData: Partial<Stars>,
  ): Promise<StandardResponseDto> {
    const result = await this.starsService.getAllStar(bodyData);
    return new StandardResponseDto(200, 'api.common.ok', result);
  }
  @Post('like-request')
  async likeRequest(
    @Body() bodyData: Partial<Stars>,
  ): Promise<StandardResponseDto> {
    const result = await this.starsService.likeRequest(bodyData);
    if (!result) {
      return new StandardResponseDto(200, 'api.common.ok', result);
    }
    return new StandardResponseDto(201, 'api.common.created', result);
  }
}
