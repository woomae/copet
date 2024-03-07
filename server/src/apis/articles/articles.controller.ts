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
    FilesInterceptor('img_name', 5, {
      limits: { fileSize: 10 * 1024 * 1024 }, // 파일 사이즈 제한을 설정합니다. 여기선 10MB),
    }),
  )
  async createArticle(
    @UploadedFiles() files: Express.Multer.File[],
    @Body() bodyData: CreateArticleDto,
  ): Promise<StandardResponseDto> {
    const result = await this.articlesService.createArticle(bodyData, files);
    return new StandardResponseDto(201, 'api.common.created', result);
  }
  // @Put(':id/update')
  // @UseInterceptors(
  //   //사진저장 미들웨어
  //   FilesInterceptor('img_name', 3, {
  //     limits: { fileSize: 5 * 1024 * 1024 }, // 파일 사이즈 제한을 설정합니다. 여기선 5MB),
  //   }),
  // )
  // async updateArticle(
  //   @UploadedFiles() files: Express.Multer.File[],
  //   @Body() bodyData: CreateArticleDto,
  //   @Param('id') id: number,
  // ): Promise<StandardResponseDto> {
  //   const result = await this.articlesService.updateArticle(
  //     id,
  //     bodyData,
  //     files,
  //   );
  //   return new StandardResponseDto(200, 'api.common.success', result);
  // }
}
