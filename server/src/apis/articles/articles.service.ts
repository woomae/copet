import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { ArticleRepository } from './articles.repository';
import { Articles } from './articles.entity';
import { CreateArticleDto } from 'src/dto/create-article.dto';
import { UsersService } from '../users/users.service';

@Injectable()
export class ArticlesService {
  constructor(
    @InjectRepository(ArticleRepository)
    private articleRepository: ArticleRepository,
    private usersService: UsersService,
  ) {}
  async getArticleById(id: number): Promise<Articles> {
    const found = await this.articleRepository.getArticleById(id);
    if (!found) {
      throw new BadRequestException(`Article with ID "${id}" not found`);
    }
    return found;
  }
  async getAllArticles(page: number, size: number): Promise<any> {
    return await this.articleRepository.getAllArticles(page, size);
  }
  async createArticle(
    bodyData: CreateArticleDto,
    files: Express.Multer.File[],
  ): Promise<any> {
    const imagePaths = files.map((file) => file.path); // 업로드된 파일들의 경로를 배열로 가져옵니다.
    const imgName = imagePaths.join(',');
    const userData = await this.usersService.findUserById(bodyData.owner_id);
    if (!userData) {
      throw new BadRequestException(
        `User with ID "${bodyData.owner_id}" not found`,
      );
    }
    const newBodyData: CreateArticleDto = {
      ...bodyData,
      author: userData?.nickname,
      img_name: imgName,
    };
    return await this.articleRepository.createArticle(newBodyData);
  }
}
