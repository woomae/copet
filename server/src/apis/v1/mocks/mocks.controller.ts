import { Controller, Get, Query, UseInterceptors } from '@nestjs/common';
import { MocksService } from './mocks.service';
import { LoggingInterceptor } from 'src/libs/logger/logger.intrecepter';

@Controller('mocks')
export class MocksController {
  constructor(private readonly mocksService: MocksService) {}
  @Get('petPlaces')
  @UseInterceptors(LoggingInterceptor)
  async getPetPlaces(
    @Query('page') page: number = 1,
    @Query('size') size: number = 10,
    @Query('region') region: string,
  ) {
    const result = await this.mocksService.getPetPlaces(page, size, region);
    return result;
  }

  @Get('merchandises')
  @UseInterceptors(LoggingInterceptor)
  async getMerchandises(
    @Query('page') page: number = 1,
    @Query('size') size: number = 10,
  ) {
    const result = await this.mocksService.getMerchandises(page, size);
    return result;
  }
}
