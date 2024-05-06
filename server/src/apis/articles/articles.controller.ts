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
import { StandardResponseDto } from 'src/dto/standard-response.dto';
import { CreateArticleDto } from 'src/dto/create-article.dto';
import { FilesInterceptor } from '@nestjs/platform-express';
import ResponseFormat from 'src/common/response-format';
import { LoggingInterceptor } from 'src/common/logger/logger.intrecepter';

@Controller('articles')
export class ArticlesController {
  constructor(private readonly articlesService: ArticlesService) {}
  @Get('')
  @UseInterceptors(LoggingInterceptor)
  async getAllArticles(
    @Query('page') page: number = 1,
    @Query('size') size: number = 10,
    @Query('category') category: string,
  ): Promise<any> {
    let result;
    let response;
    try {
      result = await this.articlesService.getAllArticles(page, size, category);
      response = ResponseFormat.ok(result).format();
    } catch (error) {
      response = ResponseFormat.fail(error).format();
    }
    return response;
  }
  @Get('owner')
  @UseInterceptors(LoggingInterceptor)
  async getAllArticleByOwner(
    @Query('owner_id') owner_id: number,
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.articlesService.getAllArticleByOwner(owner_id);
      response = ResponseFormat.ok(result).format();
    } catch (error) {
      response = ResponseFormat.fail(error).format();
    }
    return response;
  }
  @Get(':id')
  @UseInterceptors(LoggingInterceptor)
  async getArticleById(
    @Param('id') article_id: number,
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.articlesService.getArticleById(article_id);
      response = ResponseFormat.ok(result).format();
    } catch (error) {
      response = ResponseFormat.fail(error).format();
    }
    return response;
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
  ): Promise<any> {
    let result;
    let response;
    try {
      if (!files || !files.img_name || files.img_name.length === 0) {
        // 파일이 업로드되지 않았을 때 처리
        result = await this.articlesService.createArticle(bodyData, undefined);
      } else {
        result = await this.articlesService.createArticle(
          bodyData,
          files.img_name,
        );
      }
      response = ResponseFormat.ok(result).format();
    } catch (error) {
      response = ResponseFormat.fail(error).format();
    }
    return response;
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
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.articlesService.updateArticle(
        article_id,
        bodyData,
        files?.img_name,
      );
      response = ResponseFormat.ok(result).format();
    } catch (error) {
      response = ResponseFormat.fail(error).format();
    }
    return response;
  }

  @Delete(':id/delete')
  @UseInterceptors(LoggingInterceptor)
  async deleteArticle(
    @Param('id') article_id: number,
    @Body('owner_id') owner_id: number,
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.articlesService.deleteArticle(article_id, owner_id);
      response = ResponseFormat.ok(result).format();
    } catch (error) {
      response = ResponseFormat.fail(error).format();
    }
    return response;
  }
}
