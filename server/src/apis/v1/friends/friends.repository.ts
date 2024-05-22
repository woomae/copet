import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { Friends } from './friends.entity';

@Injectable()
export class FriendsRepository extends Repository<Friends> {
  constructor(dataSource: DataSource) {
    super(Friends, dataSource.createEntityManager());
  }
  async createFriendRequest(
    friendRequestData: Partial<Friends>,
  ): Promise<Friends> {
    return await this.save(friendRequestData);
  }
  async getFollowList(from_user_id: number): Promise<[Friends[], number]> {
    const result = await this.createQueryBuilder('friends')
      .leftJoinAndSelect('friends.friend_user_id', 'user')
      .where('friends.from_user_id = :from_user_id', {
        from_user_id: from_user_id,
      })
      .getManyAndCount();
    return result;
  }
  async getFollowerList(from_user_id: number): Promise<[Friends[], number]> {
    //from_user_id가 friend_user_id인 from_user_id조회
    const result = await this.createQueryBuilder('friends')
      .leftJoin('friends.friend_user_id', 'user')
      .where('friends.friend_user_id = :from_user_id', {
        from_user_id: from_user_id,
      })
      .getManyAndCount();
    return result;
  }
  async friendChecker(friendRequestData: Partial<Friends>): Promise<boolean> {
    const result = await this.createQueryBuilder('friends')
      .leftJoinAndSelect('friends.friend_user_id', 'user')
      .where('friends.from_user_id = :fromUserId', {
        fromUserId: friendRequestData.from_user_id,
      })
      .andWhere('user._id = :friendUserId', {
        friendUserId: friendRequestData.friend_user_id,
      })
      .getOne();
    if (result) {
      return true;
    } else {
      return false;
    }
  }
  async deleteFriendRequest(friendRequestData: Partial<Friends>): Promise<any> {
    const result = await this.createQueryBuilder('friends')
      .leftJoinAndSelect('friends.friend_user_id', 'user')
      .where('friends.from_user_id = :fromUserId', {
        fromUserId: friendRequestData.from_user_id,
      })
      .andWhere('user._id = :friendUserId', {
        friendUserId: friendRequestData.friend_user_id,
      })
      .getOne();
    return await this.delete({ _id: result._id });
  }
}
