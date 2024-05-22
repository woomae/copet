import { Controller, Get, Query } from '@nestjs/common';
import { MocksService } from './mocks.service';

@Controller('mocks')
export class MocksController {
  constructor(private readonly mocksService: MocksService) {}
  @Get('petPlaces')
  async getPetPlaces(
    @Query('page') page: number = 1,
    @Query('size') size: number = 10,
    @Query('region') region: string,
  ) {
    const result = await this.mocksService.getPetPlaces(page, size, region);
    return result;
  }

  @Get('merchandises')
  async getMerchandises(
    @Query('page') page: number = 1,
    @Query('size') size: number = 10,
  ) {
    const result = await this.mocksService.getMerchandises(page, size);
    return result;
  }
}
