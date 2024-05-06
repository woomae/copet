import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  UseInterceptors,
} from '@nestjs/common';
import { CommentsService } from './comments.service';
import { StandardResponseDto } from 'src/dto/standard-response.dto';
import { CreateCommentDto } from 'src/dto/create-comment.dto';
import ResponseFormat from 'src/common/response-format';
import { LoggingInterceptor } from 'src/common/logger/logger.intrecepter';

@Controller('comments')
export class CommentsController {
  constructor(private readonly commentsService: CommentsService) {}
  @Get(':id')
  @UseInterceptors(LoggingInterceptor)
  async getAllCommentsByArticle(
    @Param('id') connected_article_id: number,
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result =
        await this.commentsService.getAllCommentsByArticle(
          connected_article_id,
        );
      response = ResponseFormat.ok(result).format();
    } catch (error) {
      response = ResponseFormat.fail(error).format();
    }
    return response;
  }
  @Post('create')
  @UseInterceptors(LoggingInterceptor)
  async createComment(
    @Body() bodyData: CreateCommentDto,
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.commentsService.createComment(bodyData);
      response = ResponseFormat.ok(result).format();
    } catch (error) {
      response = ResponseFormat.fail(error).format();
    }
    return response;
  }
  @Delete(':id/delete')
  @UseInterceptors(LoggingInterceptor)
  async deleteComment(
    @Param('id') comment_id: number,
    @Body() bodyData: any,
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.commentsService.deleteComment(
        comment_id,
        bodyData.user_id,
      );
      response = ResponseFormat.ok(result).format();
    } catch (error) {
      response = ResponseFormat.fail(error).format();
    }
    return response;
  }
}
