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
  async findOne(options: any): Promise<Users> {
    const found = await this.usersRepository.findOne(options);
    return found;
  }
  async createUser(user: Users): Promise<Users> {
    return await this.usersRepository.save(user);
  }
}
