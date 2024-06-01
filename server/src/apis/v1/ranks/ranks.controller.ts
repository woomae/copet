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
@Controller({ path: 'ranks', version: '1' })
export class RanksController {
  constructor(private readonly ranksService: RanksService) {}

  @UseGuards(JwtAuthGuard)
  @Post('')
  async addSearchTerm(@Req() req: Request, @Body('term') term: string) {
    const userPayload = req.user as Payload;
    const result = await this.ranksService.addSearchTerm(
      userPayload.user_id,
      term,
    );
    return result;
  }

  @UseGuards(JwtAuthGuard)
  @Delete('recent')
  async deleteRecentSearchTerms(
    @Req() req: Request,
    @Query('term') term: string,
  ) {
    const userPayload = req.user as Payload;
    const result = await this.ranksService.deleteRecentSearchTerms(
      userPayload.user_id,
      term,
    );
    return result;
  }

  @UseGuards(JwtAuthGuard)
  @Get('recent')
  async getRecentSearchTerms(@Req() req: Request) {
    const userPayload = req.user as Payload;
    const result = await this.ranksService.getRecentSearchTerms(
      userPayload.user_id,
    );
    return result;
  }

  @Get('top')
  async getTopSearchTerms() {
    const result = await this.ranksService.getTopSearchTerms();
    return result;
  }
}
