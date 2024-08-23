import {
  Body,
  Controller,
  Delete,
  Get,
  Post,
  Query,
  Req,
  UseGuards,
} from '@nestjs/common';
import { RanksService } from './ranks.service';
import { JwtAuthGuard } from '../auth/jwt/jwt.guard';
import { Request } from 'express';
import { Payload } from '../auth/jwt/jwt.payload';
import { User } from 'src/common/decorators/user.decorator';
@Controller({ path: 'ranks', version: '1' })
export class RanksController {
  constructor(private readonly ranksService: RanksService) {}

  @UseGuards(JwtAuthGuard)
  @Post('')
  async addSearchTerm(@User() user: Payload, @Body('term') term: string) {
    const result = await this.ranksService.addSearchTerm(user.user_id, term);
    return result;
  }

  @UseGuards(JwtAuthGuard)
  @Delete('recent')
  async deleteRecentSearchTerms(
    @User() user: Payload,
    @Query('term') term: string,
  ) {
    const result = await this.ranksService.deleteRecentSearchTerms(
      user.user_id,
      term,
    );
    return result;
  }

  @UseGuards(JwtAuthGuard)
  @Get('recent')
  async getRecentSearchTerms(@User() user: Payload) {
    const result = await this.ranksService.getRecentSearchTerms(user.user_id);
    return result;
  }

  @Get('top')
  async getTopSearchTerms() {
    const result = await this.ranksService.getTopSearchTerms();
    return result;
  }
}
