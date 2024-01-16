import { Controller, Get, Param } from '@nestjs/common';
import { ArticlesService } from './articles.service';
import { Article } from './article.entity';

@Controller('articles')
export class ArticlesController {
  constructor(private readonly articlesService: ArticlesService) {}

  @Get('/:id')
  getArticleById(@Param('id') id: number): Promise<Article> {
    return this.articlesService.getArticleById(id);
  }
}
