import { BadRequestException, Injectable } from '@nestjs/common';
import { Users } from './users.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { UsersRepository } from './users.repository';

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(UsersRepository)
    private usersRepository: UsersRepository,
  ) {}
  async findAll(): Promise<Users[]> {
    const users = await this.usersRepository.find();
    if (users) {
      return users;
    } else {
      throw new Error('No users found');
    }
  }
  async findUserById(id: number): Promise<Users> {
    const found = await this.usersRepository.findUser({ where: { _id: id } });
    return found;
  }
  async findUserByEmail(email: number): Promise<Users> {
    const found = await this.usersRepository.findUser({
      where: { email: email },
    });

    return found;
  }
  async createUser(user: Users): Promise<Users> {
    return await this.usersRepository.save(user);
  }
  async initUser(
    id: number,
    updatedUser: Partial<Users>,
    file: Express.Multer.File,
  ): Promise<Users> {
    // 파일 경로를 추출하여 업데이트할 유저 정보에 추가
    const filePath = file.path; // 파일 경로 추출
    //객체의 모든 값이 null or undefined or 빈문자열이 아닌지 확인
    if (Object.values(updatedUser).some((value) => !value))
      throw new BadRequestException('Invalid input userdata');
    const newUpdateUser = { ...updatedUser, petimg: filePath };
    //update
    await this.usersRepository.initUser({ _id: id }, newUpdateUser);
    return await this.usersRepository.findUser({ where: { _id: id } });
  }
}
