import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
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

@Controller({ path: 'articles', version: '1' })
export class ArticlesController {
  constructor(private readonly articlesService: ArticlesService) {}
  @Get('')
  async getAllArticles(
    @Query('page') page: string = '1',
    @Query('size') size: string = '10',
    @Query('owner') owner?: string,
    @Query('q') q?: string,
    @Query('category') category?: string,
  ) {
    const pageInt = parseInt(page, 10);
    const sizeInt = parseInt(size, 10);
    const ownerInt = parseInt(owner, 10);
    if (q) {
      const result = await this.articlesService.searchArticles(
        q,
        pageInt,
        sizeInt,
      );
      return result;
    }
    if (ownerInt) {
      const result = await this.articlesService.getAllArticleByOwner(
        ownerInt,
        pageInt,
        sizeInt,
      );
      return result;
    }

    const result = await this.articlesService.getAllArticles(
      pageInt,
      sizeInt,
      category,
    );
    return result;
  }
  @Get(':id')
  async getArticleById(@Param('id') _id: number) {
    const result = await this.articlesService.getArticleById(_id);
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
    @Req() req: Request,
    @Body() createArticleDto: CreateArticleDto,
    @UploadedFiles() files?: { photo: Express.Multer.File[] },
  ) {
    const userPayload = req.user as Payload;
    const result = await this.articlesService.createArticle(
      createArticleDto,
      userPayload.user_id,
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
    @Req() req: Request,
    @Body() bodyData: CreateArticleDto,
    @Param('id') _id: number,
  ) {
    const userPayload = req.user as Payload;
    const result = await this.articlesService.updateArticle(
      _id,
      userPayload.user_id,
      bodyData,
      files,
    );
    return result;
  }

  @UseGuards(JwtAuthGuard)
  @Delete(':id')
  async deleteArticle(@Param('id') id: number, @Req() req: Request) {
    const userPayload = req.user as Payload;
    const result = await this.articlesService.deleteArticle(
      id,
      userPayload.user_id,
    );
    return result;
  }
}
