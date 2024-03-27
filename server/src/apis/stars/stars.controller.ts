import { Get, Controller, Post, Body } from '@nestjs/common';
import { StarsService } from './stars.service';
import { StandardResponseDto } from 'src/dto/standard-response.dto';
import { Stars } from './stars.entity';
import ResponseFormat from 'src/common/response-format';

@Controller('stars')
export class StarsController {
  constructor(private readonly starsService: StarsService) {}
  @Get('')
  async getAllStar(
    @Body() bodyData: Partial<Stars>,
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.starsService.getAllStar(bodyData);
      response = ResponseFormat.ok(result).format();
    } catch (error) {
      response = ResponseFormat.fail(error).format();
    }
    return response;
  }
  @Post('like-request')
  async likeRequest(
    @Body() bodyData: Partial<Stars>,
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.starsService.likeRequest(bodyData);
      response = ResponseFormat.ok(result).format();
    } catch (error) {
      response = ResponseFormat.fail(error).format();
    }
    return response;
  }
}
