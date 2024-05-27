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

@Controller('articles')
export class ArticlesController {
  constructor(private readonly articlesService: ArticlesService) {}
  @Get('')
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
  async getAllArticleByOwner(@Query('owner_id') owner_id: number) {
    const result = await this.articlesService.getAllArticleByOwner(owner_id);
    return result;
  }
  @Get(':id')
  async getArticleById(@Param('id') article_id: number) {
    const result = await this.articlesService.getArticleById(article_id);
    return result;
  }

  @Post('')
  @UseInterceptors(
    FilesInterceptor('img_name', 5, {
      limits: { fileSize: 10 * 1024 * 1024 }, // 파일 사이즈 제한을 설정합니다. 여기선 10MB),
    }),
  )
  async createArticle(
    @UploadedFiles() files: { img_name: Express.Multer.File[] },
    @Body() bodyData: CreateArticleDto,
  ) {
    if (!files) {
      // 파일이 업로드되지 않았을 때 처리
      const result = await this.articlesService.createArticle(
        bodyData,
        undefined,
      );
      return result;
    } else {
      const result = await this.articlesService.createArticle(bodyData, files);
      return result;
    }
  }
  @Put(':id')
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
      files,
    );
    return result;
  }

  @Delete(':id')
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
