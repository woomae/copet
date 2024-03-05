import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { ArticleRepository } from './articles.repository';
import { Articles } from './articles.entity';
import { CreateArticleDto } from 'src/dto/create-article.dto';
import { UsersService } from '../users/users.service';
import { categoryChecker } from 'src/lib/category-checker';
import * as fs from 'fs/promises';
import { ImageSaver } from 'src/lib/image-saver';
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
    const imagesaver = new ImageSaver(); // ImageSaver 클래스를 인스턴스화합니다.
    const userData = await this.usersService.findUserById(bodyData.owner_id);
    if (!userData) {
      throw new BadRequestException(
        `User with ID "${bodyData.owner_id}" not found`,
      );
    }
    const catList = ['일상', '도움', 'Q&A', '정보&후기'];
    if (!catList.includes(bodyData.category)) {
      throw new BadRequestException('category not found');
    } // 카테고리 체크
    if (!files) {
      //사진데이터 미존재시 처리
      const newBodyData: CreateArticleDto = {
        ...bodyData,
        author: userData?.nickname,
      };
      return await this.articleRepository.createArticle(newBodyData);
    } else {
      await imagesaver.saveFilesToDisk(files); // 파일 저장
      const imgName = imagesaver.getImagePaths(files); // 파일 경로 가져오기
      const newBodyData: CreateArticleDto = {
        ...bodyData,
        author: userData?.nickname,
        img_name: imgName,
      };
      return await this.articleRepository.createArticle(newBodyData);
    }
  }
  async updateArticle(
    id: number,
    bodyData: CreateArticleDto,
    files: Express.Multer.File[],
  ): Promise<any> {
    const articleData = await this.getArticleById(id);
    if (!articleData) {
      throw new BadRequestException(`Article with ID "${id}" not found`);
    }
    if (articleData.img_name) {
      const imgPaths = articleData.img_name.split(',');
      for (const imagePath of imgPaths) {
        await fs.unlink(imagePath); // 이미지 파일 삭제
      }
      const userData = await this.usersService.findUserById(bodyData.owner_id);
      if (!userData) {
        throw new BadRequestException(
          `User with ID "${bodyData.owner_id}" not found`,
        );
      }
      categoryChecker(bodyData.category); // 카테고리 체크
      if (!files) {
        //사진데이터 미존재시 처리
        const newBodyData: CreateArticleDto = {
          ...bodyData,
          author: userData?.nickname,
        };
        return await this.articleRepository.updateArticle(id, newBodyData);
      }
      const imagePaths = files.map((file) => file.path); // 업로드된 파일들의 경로를 배열로 가져옵니다.
      const imgName = imagePaths.join(',');
      const newBodyData: CreateArticleDto = {
        ...bodyData,
        author: userData?.nickname,
        img_name: imgName,
      };
      return await this.articleRepository.updateArticle(id, newBodyData);
    }
  }
}
