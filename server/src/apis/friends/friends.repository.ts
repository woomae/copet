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
  async getFriendsList(id: number): Promise<Friends[]> {
    return await this.find({
      where: { from_user_id: id },
      relations: ['friend_user_id'], // "friend_user_id"와 연관된 엔티티를 함께 로드
    });
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
    console.log(result);
    if (result) {
      return true;
    } else {
      return false;
    }
  }
}
