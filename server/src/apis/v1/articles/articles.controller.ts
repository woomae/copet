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
    @Query('q') q?: string,
    @Query('page') page: number = 1,
    @Query('size') size: number = 10,
    @Query('category') category?: string,
  ) {
    if (q) {
      const result = await this.articlesService.searchArticles(q, page, size);
      return result;
    } else {
      const result = await this.articlesService.getAllArticles(
        page,
        size,
        category,
      );
      return result;
    }
  }
  @Get('owner')
  async getAllArticleByOwner(@Query('owner_id') owner_id: number) {
    const result = await this.articlesService.getAllArticleByOwner(owner_id);
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
    FileFieldsInterceptor([{ name: 'photos', maxCount: 5 }], {
      limits: { fileSize: 25 * 1024 * 1024 },
    }),
  )
  async createArticle(
    @Req() req: Request,
    @Body() createArticleDto: CreateArticleDto,
    @UploadedFiles() files?: { img_name: Express.Multer.File[] },
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
    FileFieldsInterceptor([{ name: 'photos', maxCount: 5 }], {
      limits: { fileSize: 25 * 1024 * 1024 },
    }),
  )
  async updateArticle(
    @UploadedFiles() files: { img_name: Express.Multer.File[] },
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
  async deleteArticle(@Param('id') _id: number, @Req() req: Request) {
    const userPayload = req.user as Payload;
    const result = await this.articlesService.deleteArticle(
      _id,
      userPayload.user_id,
    );
    return result;
  }
}
