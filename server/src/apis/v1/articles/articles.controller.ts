import {
  Body,
  Controller,
  DefaultValuePipe,
  Delete,
  Get,
  Param,
  ParseIntPipe,
  Post,
  Put,
  Query,
  Req,
  UploadedFiles,
  UseGuards,
  UseInterceptors,
} from '@nestjs/common';
import { ArticlesService } from './articles.service';
import { CreateArticleDto } from 'src/dto/create-article.dto';
import { FileFieldsInterceptor } from '@nestjs/platform-express';
import { JwtAuthGuard } from '../auth/jwt/jwt.guard';
import { Request } from 'express';
import { Payload } from '../auth/jwt/jwt.payload';
import { User } from 'src/common/decorators/user.decorator';
import { getArticleQueryDto } from 'src/dto/getArticleQuery.dto';

@Controller({ path: 'articles', version: '1' })
export class ArticlesController {
  constructor(private readonly articlesService: ArticlesService) {}
  @Get('')
  async getAllArticles(@Query() query: getArticleQueryDto) {
    if (query.q) {
      const result = await this.articlesService.searchArticles(query);
      return result;
    }
    if (query.owner) {
      const result = await this.articlesService.getAllArticleByOwner(query);
      return result;
    }

    const result = await this.articlesService.getAllArticles(query);
    return result;
  }
  @UseGuards(JwtAuthGuard)
  @Get(':id')
  async getArticleById(@Param('id') _id: number, @User() user: Payload) {
    const result = await this.articlesService.getArticleById(_id, user.user_id);
    return result;
  }

  @UseGuards(JwtAuthGuard)
  @Post('')
  @UseInterceptors(
    FileFieldsInterceptor([{ name: 'photo', maxCount: 5 }], {
      limits: { fileSize: 25 * 1024 * 1024 },
    }),
  )
  async createArticle(
    @User() user: Payload,
    @Body() createArticleDto: CreateArticleDto,
    @UploadedFiles() files?: { photo: Express.Multer.File[] },
  ) {
    const result = await this.articlesService.createArticle(
      createArticleDto,
      user.user_id,
      files,
    );
    return result;
  }
  @UseGuards(JwtAuthGuard)
  @Put(':id')
  @UseInterceptors(
    FileFieldsInterceptor([{ name: 'photo', maxCount: 5 }], {
      limits: { fileSize: 25 * 1024 * 1024 },
    }),
  )
  async updateArticle(
    @UploadedFiles() files: { photo: Express.Multer.File[] },
    @User() user: Payload,
    @Body() bodyData: CreateArticleDto,
    @Param('id') _id: number,
  ) {
    const result = await this.articlesService.updateArticle(
      _id,
      user.user_id,
      bodyData,
      files,
    );
    return result;
  }

  @UseGuards(JwtAuthGuard)
  @Delete(':id')
  async deleteArticle(@Param('id') id: number, @User() user: Payload) {
    const result = await this.articlesService.deleteArticle(id, user.user_id);
    return result;
  }
}
