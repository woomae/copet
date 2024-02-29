import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { ArticleRepository } from './articles.repository';
import { Articles } from './articles.entity';
import { CreateArticleDto } from 'src/dto/create-article.dto';

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
  async getAllArticles(page: number, size: number): Promise<any> {
    return await this.articleRepository.getAllArticles(page, size);
  }
  async createArticle(bodyData: CreateArticleDto): Promise<CreateArticleDto> {
    return await this.articleRepository.createArticle(bodyData);
  }
}
