import { Body, Controller, Delete, Get, Param, Post } from '@nestjs/common';
import { CommentsService } from './comments.service';
import { CreateCommentDto } from 'src/dto/create-comment.dto';

@Controller('comments')
export class CommentsController {
  constructor(private readonly commentsService: CommentsService) {}
  @Get(':id')
  async getAllCommentsByArticle(@Param('id') connected_article_id: number) {
    const result =
      await this.commentsService.getAllCommentsByArticle(connected_article_id);

    return result;
  }
  @Post('')
  async createComment(@Body() bodyData: CreateCommentDto) {
    const result = await this.commentsService.createComment(bodyData);
    return result;
  }
  @Delete(':id')
  async deleteComment(@Param('id') comment_id: number, @Body() bodyData: any) {
    const result = await this.commentsService.deleteComment(
      comment_id,
      bodyData.user_id,
    );
    return result;
  }
}
