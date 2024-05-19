import {
  Body,
  Controller,
  Delete,
  Get,
  Post,
  Query,
  UseInterceptors,
} from '@nestjs/common';
import { RanksService } from './ranks.service';
import { LoggingInterceptor } from 'src/common/logger/logger.intrecepter';
import { StandardResponseDto } from 'src/dto/standard-response.dto';
import ResponseFormat from 'src/common/response-format';

@Controller('ranks')
export class RanksController {
  constructor(private readonly ranksService: RanksService) {}

  @Post('add')
  @UseInterceptors(LoggingInterceptor)
  async addSearchTerm(
    @Body('userId') userId: number,
    @Body('term') term: string,
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.ranksService.addSearchTerm(userId, term);
      response = ResponseFormat.ok(result).format();
    } catch (error) {
      response = ResponseFormat.fail(error).format();
    }
    return response;
  }

  @Delete('recent')
  @UseInterceptors(LoggingInterceptor)
  async deleteRecentSearchTerms(
    @Query('userId') userId: number,
    @Query('term') term: string,
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.ranksService.deleteRecentSearchTerms(userId, term);
      response = ResponseFormat.ok(result).format();
    } catch (error) {
      response = ResponseFormat.fail(error).format();
    }
    return response;
  }

  @Get('recent')
  @UseInterceptors(LoggingInterceptor)
  async getRecentSearchTerms(
    @Query('userId') userId: number,
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.ranksService.getRecentSearchTerms(userId);
      response = ResponseFormat.ok(result).format();
    } catch (error) {
      response = ResponseFormat.fail(error).format();
    }
    return response;
  }

  @Get('top')
  @UseInterceptors(LoggingInterceptor)
  async getTopSearchTerms(): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.ranksService.getTopSearchTerms();
      response = ResponseFormat.ok(result).format();
    } catch (error) {
      response = ResponseFormat.fail(error).format();
    }
    return response;
  }
}
