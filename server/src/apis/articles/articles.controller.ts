import {
  Body,
  Controller,
  Get,
  Param,
  Post,
  Query,
  UploadedFiles,
  UseInterceptors,
} from '@nestjs/common';
import { ArticlesService } from './articles.service';
import { StandardResponseDto } from 'src/dto/standard-response.dto';
import { CreateArticleDto } from 'src/dto/create-article.dto';
import { FilesInterceptor } from '@nestjs/platform-express';
import { diskStorage } from 'multer';

@Controller('articles')
export class ArticlesController {
  constructor(private readonly articlesService: ArticlesService) {}
  @Get(':id')
  async getArticleById(@Param('id') id: number): Promise<StandardResponseDto> {
    const result = await this.articlesService.getArticleById(id);
    return new StandardResponseDto(200, 'api.common.success', result);
  }
  @Get('')
  async getAllArticles(
    @Query('page') page: number = 1,
    @Query('size') size: number = 10,
  ): Promise<StandardResponseDto> {
    const result = await this.articlesService.getAllArticles(page, size);
    return new StandardResponseDto(200, 'api.common.success', result);
  }
  @Post('create')
  @UseInterceptors(
    //사진저장 미들웨어
    FilesInterceptor('img_name', 3, {
      storage: diskStorage({
        destination: './uploads', // 파일 저장 경로를 지정합니다.
        filename: (req, file, callback) => {
          const filename = `${Date.now()}-${file.originalname}`;
          callback(null, filename);
        },
      }),
    }),
  )
  async createArticle(
    @UploadedFiles() files: Express.Multer.File[],
    @Body() bodyData: CreateArticleDto,
  ): Promise<any> {
    const result = await this.articlesService.createArticle(bodyData, files);
    return new StandardResponseDto(201, 'api.common.created', result);
  }
}
