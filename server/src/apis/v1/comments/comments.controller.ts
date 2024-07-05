import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Req,
  UseGuards,
} from '@nestjs/common';
import { CommentsService } from './comments.service';
import { CreateCommentDto } from 'src/dto/create-comment.dto';
import { Payload } from '../auth/jwt/jwt.payload';
import { JwtAuthGuard } from '../auth/jwt/jwt.guard';
import { UpdateCommentDto } from 'src/dto/update-comment.dto';
import { User } from 'src/common/decorators/user.decorator';

@Controller({ path: 'comments', version: '1' })
export class CommentsController {
  constructor(private readonly commentsService: CommentsService) {}
  @Get(':id')
  async getAllCommentsByArticle(@Param('id') article_id: number) {
    const result =
      await this.commentsService.getAllCommentsByArticle(article_id);
    return result;
  }
  @UseGuards(JwtAuthGuard)
  @Post('')
  async createComment(
    @User() user: Payload,
    @Body() bodyData: CreateCommentDto,
  ) {
    const result = await this.commentsService.createComment(
      user.user_id,
      bodyData,
    );
    return result;
  }
  @UseGuards(JwtAuthGuard)
  @Patch(':id')
  async updateComment(
    @User() user: Payload,
    @Param('id') id: number,
    @Body() updateCommentDto: UpdateCommentDto,
  ) {
    const result = await this.commentsService.updateComment(
      id,
      user.user_id,
      updateCommentDto,
    );
    return result;
  }

  @UseGuards(JwtAuthGuard)
  @Delete(':id')
  async deleteComment(@User() user: Payload, @Param('id') id: number) {
    const result = await this.commentsService.deleteComment(id, user.user_id);
    return result;
  }
}
