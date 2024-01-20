import { Controller, Get, Param } from '@nestjs/common';
import { ArticlesService } from './articles.service';
import { Articles } from './articles.entity';

@Controller('articles')
export class ArticlesController {
  constructor(private readonly articlesService: ArticlesService) {}

  @Get('/:id')
  getArticleById(@Param('id') id: number): Promise<Articles> {
    return this.articlesService.getArticleById(id);
  }
}
