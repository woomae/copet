import {
  Controller,
  DefaultValuePipe,
  Get,
  ParseIntPipe,
  Query,
} from '@nestjs/common';
import { MocksService } from './mocks.service';

@Controller({ path: 'mocks', version: '1' })
export class MocksController {
  constructor(private readonly mocksService: MocksService) {}
  @Get('petPlaces')
  async getPetPlaces(
    @Query('region') region: string,
    @Query('page', new DefaultValuePipe('1'), ParseIntPipe) page?: number,
    @Query('size', new DefaultValuePipe('10'), ParseIntPipe) size?: number,
  ) {
    const result = await this.mocksService.getPetPlaces(page, size, region);
    return result;
  }

  @Get('merchandises')
  async getMerchandises(
    @Query('page', new DefaultValuePipe('1'), ParseIntPipe) page?: number,
    @Query('size', new DefaultValuePipe('10'), ParseIntPipe) size?: number,
  ) {
    const result = await this.mocksService.getMerchandises(page, size);
    return result;
  }
}
