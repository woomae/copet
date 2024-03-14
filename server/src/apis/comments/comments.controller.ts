import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { CommentsService } from './comments.service';
import { StandardResponseDto } from 'src/dto/standard-response.dto';
import { CreateCommentDto } from 'src/dto/create-comment.dto';

@Controller('comments')
export class CommentsController {
  constructor(private readonly commentsService: CommentsService) {}
  @Get(':id')
  async getAllCommentsByArticle(
    @Param('connected_article_id') connected_article_id: number,
  ): Promise<StandardResponseDto> {
    const result =
      await this.commentsService.getAllCommentsByArticle(connected_article_id);
    return new StandardResponseDto(200, 'api.common.ok', result);
  }
  //   @Post('create')
  //   async createComment(
  //     @Body() bodyData: CreateCommentDto,
  //   ): Promise<StandardResponseDto> {
  //     const result = await this.commentsService.createComment(bodyData);
  //     return new StandardResponseDto(201, 'api.common.created', result);
  //   }
}
