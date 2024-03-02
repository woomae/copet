import { Body, Controller, Get, Param, Post, Query } from '@nestjs/common';
import { ArticlesService } from './articles.service';
import { StandardResponseDto } from 'src/dto/standard-response.dto';
import { CreateArticleDto } from 'src/dto/create-article.dto';

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
  async createArticle(@Body() bodyData: CreateArticleDto): Promise<any> {
    const result = await this.articlesService.createArticle(bodyData);
    return new StandardResponseDto(201, 'api.common.created', result);
  }
}
