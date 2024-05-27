import { Body, Controller, Delete, Get, Post, Query } from '@nestjs/common';
import { RanksService } from './ranks.service';

@Controller('ranks')
export class RanksController {
  constructor(private readonly ranksService: RanksService) {}

  @Post('')
  async addSearchTerm(
    @Body('userId') userId: number,
    @Body('term') term: string,
  ) {
    const result = await this.ranksService.addSearchTerm(userId, term);
    return result;
  }

  @Delete('recent')
  async deleteRecentSearchTerms(
    @Query('userId') userId: number,
    @Query('term') term: string,
  ) {
    const result = await this.ranksService.deleteRecentSearchTerms(
      userId,
      term,
    );
    return result;
  }

  @Get('recent')
  async getRecentSearchTerms(@Query('userId') userId: number) {
    const result = await this.ranksService.getRecentSearchTerms(userId);
    return result;
  }

  @Get('top')
  async getTopSearchTerms() {
    const result = await this.ranksService.getTopSearchTerms();
    return result;
  }
}
