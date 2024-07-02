import { Injectable } from '@nestjs/common';
import { Users } from './users.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { UsersRepository } from './users.repository';
import { Friends } from '../friends/friends.entity';
import { UpdateUserDto } from 'src/dto/update-user.dto';
import { PhotosService } from '../photos/photos.service';
import { CallBackUserDataDto } from 'src/dto/callback-user.dto';
import { Repository } from 'typeorm';
import { PetKeywords } from '../petkeywords/petkeywords.entity';
import { Photos } from '../photos/photos.entity';
import { CreatePhotoDto } from 'src/dto/create-photo.dto';
import { prune } from 'src/libs/utils';
@Injectable()
export class UsersService {
  constructor(
    private readonly photosService: PhotosService,
    @InjectRepository(PetKeywords)
    private readonly petKetwordsRepository: Repository<PetKeywords>,
    @InjectRepository(UsersRepository)
    private usersRepository: UsersRepository,
    @InjectRepository(Photos)
    private readonly photosRepository: Repository<Photos>,
  ) {}
  async findOneByProviderId(provider_id: string): Promise<Users> {
    return this.usersRepository.findOne({
      where: { provider_id },
    });
  }
  async findUserById(id: number): Promise<Users> {
    return await this.usersRepository.findOne({
      where: { _id: id },
      relations: ['petkeywords', 'photo'],
    });
  }
  async findUserByEmail(email: string): Promise<Users> {
    const found = await this.usersRepository.findOne({
      where: { email: email },
    });
    return found;
  }
  async getFollowInfo(
    followList: [number, Friends[]],
  ): Promise<[number, Users[]]> {
    const result = [];
    for (const follow of followList[1]) {
      const user = await this.usersRepository.findOne({
        where: { _id: follow._id },
        relations: ['petkeywords', 'photo'],
      });
      user.petkeywords = user.petkeywords.map(
        (keyword) => keyword.keyword,
      ) as unknown as PetKeywords[];
      user.photo = user.photo[0]?.img_path;
      result.push(user);
    }
    return [followList[0], result];
  }
  async getFollowerInfo(
    followerList: [number, Friends[]],
  ): Promise<[number, Users[]]> {
    const result = [];
    for (const follower of followerList[1]) {
      const user = await this.usersRepository.findOne({
        where: { _id: follower.from_user_id },
        relations: ['petkeywords', 'photo'],
      });
      user.petkeywords = user.petkeywords.map(
        (keyword) => keyword.keyword,
      ) as unknown as PetKeywords[];
      user.photo = user.photo[0]?.img_path;
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
    updateUserDto = prune(updateUserDto);
    const user = await this.usersRepository.findOne({
      where: { _id: id },
    });
    Object.assign(user, updateUserDto);
    const petKeywords = await Promise.all(
      updateUserDto.petkeyword.map(async (keyword) => {
        return this.petKetwordsRepository.findOne({
          where: { keyword: keyword },
        });
      }),
    );
    user.petkeywords = petKeywords.filter(Boolean);

    const photoEntity = await this.photosRepository.findOne({
      where: { user: { _id: user._id } },
    });
    if (photoEntity) {
      await this.photosService.deleteFiles(photoEntity.img_path, '/users');
      await this.photosRepository.delete(photoEntity._id);
    }

    if (file.petimg) {
      const img_urls = await this.photosService.uploadFiles(
        file.petimg,
        '/users',
      );
      const photo = new CreatePhotoDto();
      photo.img_path = img_urls[0];
      photo.user = user;
      await this.photosRepository.save(photo);
    }
    await this.usersRepository.save(user);
    //아래 findOne은 추후 제거 예정
    return await this.usersRepository.findOne({
      where: { _id: id },
      relations: ['petkeywords', 'photo'],
    });
  }
}
