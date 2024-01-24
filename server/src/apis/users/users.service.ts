import { Injectable } from '@nestjs/common';
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
  async findUser(options: any): Promise<Users> {
    const found = await this.usersRepository.findUser(options);
    return found;
  }
  async createUser(user: Users): Promise<Users> {
    return await this.usersRepository.save(user);
  }
  async initUser(id: number, updatedUser: Partial<Users>): Promise<Users> {
    await this.usersRepository.update(id, updatedUser);
    return this.usersRepository.findUser(id); //수정필요
  }
}
