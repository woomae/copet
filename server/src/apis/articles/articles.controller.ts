import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { ArticlesService } from './articles.service';
import { Articles } from './articles.entity';
import { CreateArticleDto } from 'src/dto/create-article.dto';

@Controller('articles')
export class ArticlesController {
  constructor(private readonly articlesService: ArticlesService) {}
  @Get('/:id')
  getArticleById(@Param('id') id: number): Promise<Articles> {
    return this.articlesService.getArticleById(id);
  }
  @Get('')
  getAllArticles(
    @Param('page') page: number = 1,
    @Param('size') size: number = 10,
  ): Promise<Articles[]> {
    return this.articlesService.getAllArticles(page, size);
  }
  @Post('create')
  async createArticle(@Body() bodyData: CreateArticleDto): Promise<any> {
    return await this.articlesService.createArticle(bodyData);
  }
}
