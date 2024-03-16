import { Body, Controller, Delete, Get, Param, Post } from '@nestjs/common';
import { CommentsService } from './comments.service';
import { StandardResponseDto } from 'src/dto/standard-response.dto';
import { CreateCommentDto } from 'src/dto/create-comment.dto';
import ApiCodes from 'src/common/api.codes';
import ApiMessages from 'src/common/api.messages';

@Controller('comments')
export class CommentsController {
  constructor(private readonly commentsService: CommentsService) {}
  @Get(':id')
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
  @Post('create')
  async createComment(
    @Body() bodyData: CreateCommentDto,
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.commentsService.createComment(bodyData);
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
  @Delete(':id/delete')
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
