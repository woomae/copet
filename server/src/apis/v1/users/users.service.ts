import { BadRequestException, Injectable } from '@nestjs/common';
import { Users } from './users.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { UsersRepository } from './users.repository';
import { Friends } from '../friends/friends.entity';
import ApiError from 'src/libs/res/api.errors';
import ApiCodes from 'src/libs/res/api.codes';
import ApiMessages from 'src/libs/res/api.messages';
import { UpdateUserDto } from 'src/dto/update-user.to';
import { PhotosService } from '../photos/photos.service';
import { CallBackUserDataDto } from 'src/dto/callback-user.dto';
@Injectable()
export class UsersService {
  constructor(
    private readonly photosService: PhotosService,
    @InjectRepository(UsersRepository)
    private usersRepository: UsersRepository,
  ) {}
  async findOneByProviderId(provider_id: string): Promise<Users> {
    return this.usersRepository.findOne({
      where: { provider_id },
    });
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
  async createUser(user: CallBackUserDataDto): Promise<Users> {
    return await this.usersRepository.save(user);
  }
  async initUser(
    id: number,
    updateUserDto: UpdateUserDto,
    file?: { petimg: Express.Multer.File[] } | undefined,
  ): Promise<Users> {
    //객체의 모든 값이 null or undefined or 빈문자열이 아닌지 확인
    if (Object.values(updateUserDto).some((value) => !value))
      throw new ApiError(ApiCodes.BAD_REQUEST, ApiMessages.BAD_REQUEST, {
        message: '입력값에 문제가 있습니다.',
      });
    const bodyObject = this.usersRepository.create(updateUserDto);
    if (file.petimg) {
      const img_paths = await this.photosService.uploadFiles(
        file.petimg,
        '/petimgs',
      );
      bodyObject.petimg = img_paths[0];
    }
    await this.usersRepository.initUser({ _id: id }, bodyObject);
    return await this.usersRepository.findUser({ where: { _id: id } });
  }
}
