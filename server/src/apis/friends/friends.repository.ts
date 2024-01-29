import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { Friends } from './friends.entity';

@Injectable()
export class FriendsRepository extends Repository<Friends> {
  constructor(dataSource: DataSource) {
    super(Friends, dataSource.createEntityManager());
  }
  //   async findUser(options: any): Promise<Friends> {
  //     return await this.findOne(options);
  //   }
  //   async initUser(options: any, updatedUser: Partial<Friends>): Promise<void> {
  //     await this.update(options, updatedUser);
  //   }
  async createFriendRequest(
    friendRequestData: Partial<Friends>,
  ): Promise<Friends> {
    return await this.save(friendRequestData);
  }
}
