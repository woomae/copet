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
    @Req() req: Request,
    @Param('id') article_id: number,
    @Body() bodyData: CreateCommentDto,
  ) {
    const userPayload = req.user as Payload;
    const result = await this.commentsService.createComment(
      userPayload.user_id,
      article_id,
      bodyData,
    );
    return result;
  }
  @UseGuards(JwtAuthGuard)
  @Patch(':id')
  async updateComment(
    @Req() req: Request,
    @Param('id') _id: number,
    @Body() comment: string,
  ) {
    const userPayload = req.user as Payload;
    const result = await this.commentsService.updateComment(
      _id,
      userPayload.user_id,
      comment,
    );
    return result;
  }

  @UseGuards(JwtAuthGuard)
  @Delete(':id')
  async deleteComment(@Param('id') _id: number, @Req() req: Request) {
    const userPayload = req.user as Payload;
    const result = await this.commentsService.deleteComment(
      _id,
      userPayload.user_id,
    );
    return result;
  }
}
