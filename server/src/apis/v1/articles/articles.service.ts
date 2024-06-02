import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { ArticleRepository } from './articles.repository';
import { Articles } from './articles.entity';
import { CreateArticleDto } from 'src/dto/create-article.dto';
import { UsersService } from '../users/users.service';

import { categoryChecker } from 'src/libs/funcs/category-checker';
import { PhotosService } from '../photos/photos.service';
import ApiError from 'src/libs/res/api.errors';
import ApiCodes from 'src/libs/res/api.codes';
import ApiMessages from 'src/libs/res/api.messages';
import { ConfigService } from '@nestjs/config';
import { Repository } from 'typeorm';
import { Photos } from '../photos/photos.entity';
import { CreatePhotoDto } from 'src/dto/create-photo.dto';
@Injectable()
export class ArticlesService {
  constructor(
    private readonly env: ConfigService,
    private readonly photosService: PhotosService,
    private usersService: UsersService,
    @InjectRepository(ArticleRepository)
    private articleRepository: ArticleRepository,
    @InjectRepository(Photos)
    private readonly photosRepository: Repository<Photos>,
  ) {}
  async getArticleById(_id: number): Promise<Articles> {
    const result = await this.articleRepository.getArticleById(_id);
    return result;
  }
  async getAllArticles(
    page: number,
    size: number,
    category?: string,
  ): Promise<any> {
    //카테고리 체크
    if (category) {
      return await this.articleRepository.getAllArticlesByCategory(
        page,
        size,
        category,
      );
    }
    return await this.articleRepository.getAllArticles(page, size);
  }
  async getAllArticleByOwner(owner_id: number): Promise<Articles[]> {
    const result = await this.articleRepository.getAllArticleByOwner(owner_id);
    return result;
  }
  async createArticle(
    createArticleDto: CreateArticleDto,
    owner_id: number,
    files?: { img_name: Express.Multer.File[] } | undefined,
  ): Promise<Articles> {
    //게시글을 작성한 유저 조회 후 없을 시 에러처리
    const userData = await this.usersService.findUserById(owner_id);
    categoryChecker(createArticleDto.category); // 카테고리 체크
    const bodyObject = this.articleRepository.create(createArticleDto);
    if (files.img_name) {
      const img_paths = await this.photosService.uploadFiles(
        files.img_name,
        '/articles',
      );
      const photo = new CreatePhotoDto();
      photo.article = bodyObject;
      img_paths.forEach((img_path) => {
        photo.img_path = img_path;
        this.photosRepository.save(photo);
      });
    }
    bodyObject.owner_id = owner_id;
    bodyObject.author = userData.nickname;
    return await this.articleRepository.save(bodyObject);
  }
  async updateArticle(
    _id: number,
    owner_id: number,
    createArticleDto: CreateArticleDto,
    files?: { img_name: Express.Multer.File[] } | undefined,
  ): Promise<Articles> {
    //기존 게시글 조회 후 없을 시 에러처리
    const articleData = await this.articleRepository.getArticleById(_id);
    if (!articleData) {
      throw new ApiError(ApiCodes.NOT_FOUND, ApiMessages.NOT_FOUND, {
        message: '게시글을 찾을 수 없습니다.',
      });
    }
    //기존게시글 오너가 바디데이터의 오너가 아닐 시 에러처리
    if (await this.articleRepository.ownerChecker(_id, owner_id)) {
      throw new ApiError(ApiCodes.BAD_REQUEST, ApiMessages.BAD_REQUEST, {
        message: '게시글의 작성자가 아닙니다.',
      });
    }
    categoryChecker(createArticleDto.category); // 카테고리 체크
    // //기존 사진들 삭제
    // if (articleData.img_urls) {
    //   this.photosService.deleteFiles(articleData.img_urls, '/articles');
    //   articleData.img_urls = null;
    // }
    const bodyObject = this.articleRepository.create(createArticleDto);
    bodyObject.owner_id = owner_id;
    if (files.img_name) {
      const img_paths = await this.photosService.uploadFiles(
        files.img_name,
        '/articles',
      );
      const photo = new CreatePhotoDto();
      photo.article = bodyObject;
      img_paths.forEach((img_path) => {
        photo.img_path = img_path;
        this.photosRepository.save(photo);
      });
    }
    return await this.articleRepository.updateArticle(_id, bodyObject);
  }
  async deleteArticle(_id: number, owner_id: number): Promise<void> {
    //기존 게시글 조회 후 없을 시 에러처리
    const articleData = await this.articleRepository.getArticleById(_id);
    if (!articleData) {
      throw new ApiError(ApiCodes.NOT_FOUND, ApiMessages.NOT_FOUND, {
        message: '게시글을 찾을 수 없습니다.',
      });
    }
    //유저아이디와 게시글의 오너아이디가 같은지 확인
    if (await this.articleRepository.ownerChecker(_id, owner_id)) {
      throw new ApiError(ApiCodes.BAD_REQUEST, ApiMessages.BAD_REQUEST, {
        message: '게시글의 작성자가 아닙니다.',
      });
    }
    await this.articleRepository.delete({ _id: _id });
  }
  async increaseScrapCount(article_id: number): Promise<void> {
    await this.articleRepository.increaseScrapCount(article_id);
  }
  async decreaseScrapCount(article_id: number): Promise<void> {
    await this.articleRepository.decreaseScrapCount(article_id);
  }
  async increaseCommentCount(article_id: number): Promise<void> {
    await this.articleRepository.increaseCommentCount(article_id);
  }
  async decreaseCommentCount(article_id: number): Promise<void> {
    await this.articleRepository.decreaseCommentCount(article_id);
  }
  async searchArticles(q: string, page: number, size: number): Promise<any> {
    return await this.articleRepository.searchArticles(q, page, size);
  }
}
