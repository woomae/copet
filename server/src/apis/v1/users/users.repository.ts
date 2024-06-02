import { Injectable } from '@nestjs/common';
import { Users } from './users.entity';
import { DataSource, Repository } from 'typeorm';

@Injectable()
export class UsersRepository extends Repository<Users> {
  constructor(dataSource: DataSource) {
    super(Users, dataSource.createEntityManager());
  }
  async createUser(user: Users) {
    return await this.save(user);
  }
  async createFriendRequest(friendRequestData: Partial<Users>): Promise<void> {
    await this.save(friendRequestData);
  }
}
