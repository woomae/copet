import { Controller, Get, Query, UseInterceptors } from '@nestjs/common';
import { MocksService } from './mocks.service';
import { LoggingInterceptor } from 'src/common/logger/logger.intrecepter';
import { StandardResponseDto } from 'src/dto/standard-response.dto';
import ResponseFormat from 'src/common/response-format';

@Controller('mocks')
export class MocksController {
  constructor(private readonly mocksService: MocksService) {}
  @Get('petPlaces')
  @UseInterceptors(LoggingInterceptor)
  async getPetPlaces(
    @Query('page') page: number = 1,
    @Query('size') size: number = 10,
    @Query('region') region: string,
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.mocksService.getPetPlaces(page, size, region);
      response = ResponseFormat.ok(result).format();
    } catch (error) {
      response = ResponseFormat.fail(error).format();
    }
    return response;
  }

  @Get('merchandises')
  @UseInterceptors(LoggingInterceptor)
  async getMerchandises(
    @Query('page') page: number = 1,
    @Query('size') size: number = 10,
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.mocksService.getMerchandises(page, size);
      response = ResponseFormat.ok(result).format();
    } catch (error) {
      response = ResponseFormat.fail(error).format();
    }
    return response;
  }
}
