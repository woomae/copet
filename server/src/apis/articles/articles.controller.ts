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
import ApiCodes from 'src/common/api.codes';
import ApiMessages from 'src/common/api.messages';

@Controller('articles')
export class ArticlesController {
  constructor(private readonly articlesService: ArticlesService) {}
  @Get('')
  async getAllArticles(
    @Query('page') page: number = 1,
    @Query('size') size: number = 10,
    @Query('category') category: string,
  ): Promise<any> {
    let result;
    let response;
    try {
      result = await this.articlesService.getAllArticles(page, size, category);
      response = new StandardResponseDto(ApiCodes.OK, ApiMessages.OK, result);
    } catch (error) {
      response = new StandardResponseDto(
        error.response.statusCode,
        error.response.message,
        null,
      );
    }
    return response;
  }
  @Get('owner')
  async getAllArticleByOwner(
    @Query('owner_id') owner_id: number,
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.articlesService.getAllArticleByOwner(owner_id);
      response = new StandardResponseDto(ApiCodes.OK, ApiMessages.OK, result);
    } catch (error) {
      response = new StandardResponseDto(
        error.response.statusCode,
        error.response.message,
        null,
      );
    }
    return response;
  }
  @Get(':id')
  async getArticleById(
    @Param('id') article_id: number,
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.articlesService.getArticleById(article_id);
      response = new StandardResponseDto(ApiCodes.OK, ApiMessages.OK, result);
    } catch (error) {
      response = new StandardResponseDto(
        error.response.statusCode,
        error.response.message,
        null,
      );
    }
    return response;
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
  ): Promise<any> {
    let result;
    let response;
    try {
      result = await this.articlesService.createArticle(bodyData, files);
      response = new StandardResponseDto(
        ApiCodes.CREATED,
        ApiMessages.CREATED,
        result,
      );
    } catch (error) {
      response = new StandardResponseDto(
        error.response.statusCode,
        error.response.message,
        null,
      );
    }
    return response;
  }
  @Put(':id/update')
  @UseInterceptors(
    //사진저장 미들웨어
    FilesInterceptor('img_name', 5, {
      limits: { fileSize: 10 * 1024 * 1024 }, // 파일 사이즈 제한을 설정합니다. 여기선 10MB),
    }),
  )
  async updateArticle(
    @UploadedFiles() files: Express.Multer.File[],
    @Body() bodyData: CreateArticleDto,
    @Param('id') article_id: number,
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.articlesService.updateArticle(
        article_id,
        bodyData,
        files,
      );
      response = new StandardResponseDto(ApiCodes.OK, ApiMessages.OK, result);
    } catch (error) {
      response = new StandardResponseDto(
        error.response.statusCode,
        error.response.message,
        null,
      );
    }
    return response;
  }

  @Delete(':id/delete')
  async deleteArticle(
    @Param('id') article_id: number,
    @Body('owner_id') owner_id: number,
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.articlesService.deleteArticle(article_id, owner_id);
      response = new StandardResponseDto(ApiCodes.OK, ApiMessages.OK, result);
    } catch (error) {
      response = new StandardResponseDto(
        error.response.statusCode,
        error.response.message,
        null,
      );
    }
    return response;
  }
}