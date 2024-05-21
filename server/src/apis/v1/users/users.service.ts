import { BadRequestException, Injectable } from '@nestjs/common';
import { Users } from './users.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { UsersRepository } from './users.repository';
import { ConfigService } from '@nestjs/config';
import * as AWS from 'aws-sdk';
import { Friends } from '../friends/friends.entity';
const configService = new ConfigService();
@Injectable()
export class UsersService {
  private readonly awsS3: AWS.S3;
  public readonly S3_BUCKET_NAME: string;
  constructor(
    @InjectRepository(UsersRepository)
    private usersRepository: UsersRepository,
  ) {
    this.awsS3 = new AWS.S3({
      accessKeyId: configService.get('AWS_ACCESS_KEY_ID'),
      secretAccessKey: configService.get('AWS_SECRET_ACCESS_KEY'),
      region: configService.get('AWS_S3_REGION'),
    });
    this.S3_BUCKET_NAME = configService.get('AWS_S3_BUCKET_NAME') + '/petimgs';
  }
  async findUserById(id: number): Promise<Users> {
    const found = await this.usersRepository.findUser({ where: { _id: id } });
    if (!found) throw new BadRequestException('Invalid ID');
    return found;
  }
  async findUserByEmail(email: number): Promise<Users> {
    const found = await this.usersRepository.findUser({
      where: { email: email },
    });
    return found;
  }
  async getFollowerInfo(
    followerList: [number, Friends[]],
  ): Promise<[number, Users[]]> {
    const result = [];
    for (const follower of followerList[1]) {
      const user = await this.usersRepository.findUser({
        where: { _id: follower.from_user_id },
      });
      result.push(user);
    }
    return [followerList[0], result];
  }
  async createUser(user: Users): Promise<Users> {
    return await this.usersRepository.save(user);
  }
  async initUser(
    id: number,
    updatedUser: Partial<Users>,
    file: Express.Multer.File | undefined,
  ): Promise<Users> {
    //객체의 모든 값이 null or undefined or 빈문자열이 아닌지 확인
    if (Object.values(updatedUser).some((value) => !value))
      throw new BadRequestException('Invalid input userdata');
    //기존 사진파일 존재시 삭제
    const existingImg = await this.usersRepository.findUser({
      where: { _id: id },
    });
    if (!existingImg) throw new BadRequestException('Invalid ID');
    if (existingImg.petimg) {
      //s3에서 해당 사진 삭제
      const subindex = existingImg.petimg.indexOf('.com/') + 5;
      await this.awsS3
        .deleteObject({
          Bucket: configService.get('AWS_S3_BUCKET_NAME'),
          Key: existingImg.petimg.substring(subindex),
        })
        .promise();
    }
    if (!file || Object.keys(file).length === 0) {
      const newUpdateUser = { ...updatedUser };
      await this.usersRepository.initUser({ _id: id }, newUpdateUser);
    } else {
      const key = `user-${id}--${Date.now()}`;
      await this.awsS3
        .putObject({
          Bucket: this.S3_BUCKET_NAME,
          Key: key,
          Body: file.buffer,
          ACL: 'public-read',
          ContentType: file.mimetype,
        })
        .promise();
      const filePath = `https://${configService.get(
        'AWS_S3_BUCKET_NAME',
      )}.s3.${configService.get('AWS_S3_REGION')}.amazonaws.com/petimgs/${key}`;
      const newUpdateUser = { ...updatedUser, petimg: filePath };
      await this.usersRepository.initUser({ _id: id }, newUpdateUser);
    }
    return await this.usersRepository.findUser({ where: { _id: id } });
  }
}
