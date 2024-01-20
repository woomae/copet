import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { ArticleRepository } from './articles.repository';
import { Articles } from './articles.entity';

@Injectable()
export class ArticlesService {
  constructor(
    @InjectRepository(ArticleRepository)
    private articleRepository: ArticleRepository,
  ) {}
  async getArticleById(id: number): Promise<Articles> {
    const found = await this.articleRepository.getArticleById(id);
    if (!found) {
      throw new NotFoundException(`Article with ID "${id}" not found`);
    }
    return found;
  }
}
