import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
  Query,
  UploadedFiles,
  UseInterceptors,
} from '@nestjs/common';
import { ArticlesService } from './articles.service';
import { CreateArticleDto } from 'src/dto/create-article.dto';
import { FilesInterceptor } from '@nestjs/platform-express';
import { LoggingInterceptor } from 'src/libs/logger/logger.intrecepter';

@Controller('articles')
export class ArticlesController {
  constructor(private readonly articlesService: ArticlesService) {}
  @Get('')
  @UseInterceptors(LoggingInterceptor)
  async getAllArticles(
    @Query('q') q: string,
    @Query('page') page: number = 1,
    @Query('size') size: number = 10,
    @Query('category') category: string,
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
  @UseInterceptors(LoggingInterceptor)
  async getAllArticleByOwner(@Query('owner_id') owner_id: number) {
    const result = await this.articlesService.getAllArticleByOwner(owner_id);
    return result;
  }
  @Get(':id')
  @UseInterceptors(LoggingInterceptor)
  async getArticleById(@Param('id') article_id: number) {
    const result = await this.articlesService.getArticleById(article_id);
    return result;
  }

  @Post('create')
  @UseInterceptors(LoggingInterceptor)
  @UseInterceptors(
    FilesInterceptor('img_name', 5, {
      limits: { fileSize: 10 * 1024 * 1024 }, // 파일 사이즈 제한을 설정합니다. 여기선 10MB),
    }),
  )
  async createArticle(
    @UploadedFiles() files: { img_name: Express.Multer.File[] },
    @Body() bodyData: CreateArticleDto,
  ) {
    if (!files || !files.img_name || files.img_name.length === 0) {
      // 파일이 업로드되지 않았을 때 처리
      const result = await this.articlesService.createArticle(
        bodyData,
        undefined,
      );
      return result;
    } else {
      const result = await this.articlesService.createArticle(
        bodyData,
        files.img_name,
      );
      return result;
    }
  }
  @Put(':id/update')
  @UseInterceptors(LoggingInterceptor)
  @UseInterceptors(
    //사진저장 미들웨어
    FilesInterceptor('img_name', 5, {
      limits: { fileSize: 10 * 1024 * 1024 }, // 파일 사이즈 제한을 설정합니다. 여기선 10MB),
    }),
  )
  async updateArticle(
    @UploadedFiles() files: { img_name: Express.Multer.File[] },
    @Body() bodyData: CreateArticleDto,
    @Param('id') article_id: number,
  ) {
    const result = await this.articlesService.updateArticle(
      article_id,
      bodyData,
      files?.img_name,
    );
    return result;
  }

  @Delete(':id/delete')
  @UseInterceptors(LoggingInterceptor)
  async deleteArticle(
    @Param('id') article_id: number,
    @Body('owner_id') owner_id: number,
  ) {
    const result = await this.articlesService.deleteArticle(
      article_id,
      owner_id,
    );
    return result;
  }
}
