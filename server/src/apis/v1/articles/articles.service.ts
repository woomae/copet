import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { ArticleRepository } from './articles.repository';
import { Articles } from './articles.entity';
import { CreateArticleDto } from 'src/dto/create-article.dto';
import { UsersService } from '../users/users.service';
import * as AWS from 'aws-sdk';
import { ConfigService } from '@nestjs/config';
import { categoryChecker } from 'src/libs/funcs/category-checker';
const configService = new ConfigService();
@Injectable()
export class ArticlesService {
  private readonly awsS3: AWS.S3;
  public readonly S3_BUCKET_NAME: string;

  constructor(
    @InjectRepository(ArticleRepository)
    private articleRepository: ArticleRepository,
    private usersService: UsersService,
  ) {
    this.awsS3 = new AWS.S3({
      accessKeyId: configService.get('AWS_ACCESS_KEY_ID'),
      secretAccessKey: configService.get('AWS_SECRET_ACCESS_KEY'),
      region: configService.get('AWS_S3_REGION'),
    });
    this.S3_BUCKET_NAME = configService.get('AWS_S3_BUCKET_NAME') + '/articles';
  }
  async getArticleById(article_id: number): Promise<Articles> {
    const found = await this.articleRepository.getArticleById(article_id);
    if (!found) {
      throw new BadRequestException(
        `Article with ID "${article_id}" not found`,
      );
    }
    return found;
  }
  async getAllArticles(
    page: number,
    size: number,
    category: string,
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
    const articleData =
      await this.articleRepository.getAllArticleByOwner(owner_id);
    if (!articleData || articleData.length === 0) {
      throw new BadRequestException(
        `ArticleData with ID "${owner_id}" not found`,
      );
    }
    return articleData;
  }
  async createArticle(bodyData: CreateArticleDto, files: any): Promise<any> {
    //게시글을 작성한 유저 조회 후 없을 시 에러처리
    const userData = await this.usersService.findUserById(bodyData.owner_id);
    if (!userData) {
      throw new BadRequestException(
        `User with ID "${bodyData.owner_id}" not found`,
      );
    }
    categoryChecker(bodyData.category); // 카테고리 체크
    if (!files || Object.keys(files).length === 0) {
      //사진데이터 미존재시 처리
      const newBodyData: CreateArticleDto = {
        ...bodyData,
        author: userData?.nickname,
      };
      return await this.articleRepository.createArticle(newBodyData);
    } else {
      const img_arr = [];
      for (const file of files) {
        try {
          //사진데이터 존재시 처리
          const key = `user-${bodyData.owner_id}--${Date.now()}`;

          await this.awsS3
            .putObject({
              Bucket: this.S3_BUCKET_NAME,
              Key: key,
              Body: file.buffer,
              ACL: 'public-read',
              ContentType: file.mimetype,
            })
            .promise();

          img_arr.push(
            `https://${configService.get(
              'AWS_S3_BUCKET_NAME',
            )}.s3.${configService.get(
              'AWS_S3_REGION',
            )}.amazonaws.com/articles/${key}`,
          );
        } catch (error) {
          throw new BadRequestException(`File upload failed : ${error}`);
        }
      }
      const img_paths = img_arr.map((img) => img);
      const img_path = img_paths.join(',');
      const newBodyData: CreateArticleDto = {
        ...bodyData,
        author: userData?.nickname,
        img_name: img_path,
      };

      return await this.articleRepository.createArticle(newBodyData);
    }
  }
  async updateArticle(
    article_id: number,
    bodyData: CreateArticleDto,
    files: any,
  ): Promise<Articles> {
    //기존 게시글 조회 후 없을 시 에러처리
    const found = await this.articleRepository.getArticleById(article_id);
    if (!found) {
      throw new BadRequestException(
        `Article with ID "${article_id}" not found`,
      );
    }
    //게시글을 작성한 유저 조회 후 없을 시 에러처리
    const userData = await this.usersService.findUserById(bodyData.owner_id);
    if (!userData) {
      throw new BadRequestException(
        `User with ID "${bodyData.owner_id}" not found`,
      );
    }
    //기존게시글 오너가 바디데이터의 오너가 아닐 시 에러처리
    if (
      await this.articleRepository.ownerChecker(article_id, bodyData.owner_id)
    ) {
      throw new BadRequestException(`Article is not owned by user `);
    }
    categoryChecker(bodyData.category); // 카테고리 체크
    //기존 사진들 삭제
    if (found.img_name) {
      const img_arr = found.img_name.split(',');
      for (const img of img_arr) {
        const subindex = img.indexOf('.com/') + 5;
        await this.awsS3
          .deleteObject({
            Bucket: configService.get('AWS_S3_BUCKET_NAME'),
            Key: img.substring(subindex), //키 값은 버킷부터의 경로로 작성
          })
          .promise();
      }
    }
    if (!files || Object.keys(files).length === 0) {
      //사진데이터 미존재시 처리
      const newBodyData: CreateArticleDto = {
        ...bodyData,
        author: userData?.nickname,
        img_name: null,
      };
      return await this.articleRepository.updateArticle(
        article_id,
        newBodyData,
      );
    } else {
      const img_arr = [];
      for (const file of files) {
        try {
          const key = `user-${bodyData.owner_id}--${Date.now()}`;

          await this.awsS3
            .putObject({
              Bucket: this.S3_BUCKET_NAME,
              Key: key,
              Body: file.buffer,
              ACL: 'public-read',
              ContentType: file.mimetype,
            })
            .promise();

          img_arr.push(
            `https://${configService.get(
              'AWS_S3_BUCKET_NAME',
            )}.s3.${configService.get(
              'AWS_S3_REGION',
            )}.amazonaws.com/articles/${key}`,
          );
        } catch (error) {
          throw new BadRequestException(`File upload failed : ${error}`);
        }
      }
      const img_paths = img_arr.map((img) => img);
      const img_path = img_paths.join(',');
      const newBodyData: CreateArticleDto = {
        ...bodyData,
        author: userData?.nickname,
        img_name: img_path,
      };
      return await this.articleRepository.updateArticle(
        article_id,
        newBodyData,
      );
    }
  }
  async deleteArticle(article_id: number, owner_id: number): Promise<void> {
    //기존 게시글 조회 후 없을 시 에러처리
    const found = await this.articleRepository.getArticleById(article_id);
    if (!found) {
      throw new BadRequestException(
        `Article with ID "${article_id}" not found`,
      );
    }
    //유저아이디와 게시글의 오너아이디가 같은지 확인
    if (await this.articleRepository.ownerChecker(article_id, owner_id)) {
      throw new BadRequestException(`Article is not owned by user `);
    }
    //기존 사진들 삭제
    if (found.img_name) {
      const img_arr = found.img_name.split(',');
      for (const img of img_arr) {
        const subindex = img.indexOf('.com/') + 5;
        await this.awsS3
          .deleteObject({
            Bucket: configService.get('AWS_S3_BUCKET_NAME'),
            Key: img.substring(subindex), //키 값은 버킷부터의 경로로 작성
          })
          .promise();
      }
    }
    await this.articleRepository.delete({ _id: article_id });
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
