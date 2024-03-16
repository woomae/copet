import { Get, Controller, Post, Body } from '@nestjs/common';
import { StarsService } from './stars.service';
import { StandardResponseDto } from 'src/dto/standard-response.dto';
import { Stars } from './stars.entity';
import ApiCodes from 'src/common/api.codes';
import ApiMessages from 'src/common/api.messages';

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
      response = new StandardResponseDto(ApiCodes.OK, ApiMessages.OK, result);
    } catch (error) {
      response = new StandardResponseDto(
        error.response.statusCode,
        error.response.message,
        null,
      );
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
      response = new StandardResponseDto(ApiCodes.OK, ApiMessages.OK, result);
    } catch (error) {
      response = new StandardResponseDto(
        error.response.statusCode,
        error.response.message,
        null,
      );
    }
    return response;
  }
}
