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
import { Request } from 'express';
import { Payload } from '../auth/jwt/jwt.payload';
import { JwtAuthGuard } from '../auth/jwt/jwt.guard';
import { UpdateCommentDto } from 'src/dto/update-comment.dto';

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
  async createComment(@Req() req: Request, @Body() bodyData: CreateCommentDto) {
    const userPayload = req.user as Payload;
    const result = await this.commentsService.createComment(
      userPayload.user_id,
      bodyData,
    );
    return result;
  }
  @UseGuards(JwtAuthGuard)
  @Patch(':id')
  async updateComment(
    @Req() req: Request,
    @Param('id') id: number,
    @Body() updateCommentDto: UpdateCommentDto,
  ) {
    const userPayload = req.user as Payload;
    const result = await this.commentsService.updateComment(
      id,
      userPayload.user_id,
      updateCommentDto,
    );
    return result;
  }

  @UseGuards(JwtAuthGuard)
  @Delete(':id')
  async deleteComment(@Param('id') id: number, @Req() req: Request) {
    const userPayload = req.user as Payload;
    const result = await this.commentsService.deleteComment(
      id,
      userPayload.user_id,
    );
    return result;
  }
}
