import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { Friends } from './friends.entity';

@Injectable()
export class FriendsRepository extends Repository<Friends> {
  constructor(dataSource: DataSource) {
    super(Friends, dataSource.createEntityManager());
  }
  async createFriendRequest(
    id: number,
    friend_user_id: number,
  ): Promise<Friends> {
    const friendRequestData = new Friends();
    friendRequestData.friend_user_id = friend_user_id;
    friendRequestData.from_user_id = id;
    return await this.save(friendRequestData);
  }
  async getFollowList(from_user_id: number): Promise<[Friends[], number]> {
    const result = await this.createQueryBuilder('friends')
      .leftJoinAndSelect('friends.friend_user_id', 'user') // friends.friend_user_id를 user로 조인
      .where('friends.from_user_id = :from_user_id', {
        from_user_id: from_user_id,
      })
      .leftJoinAndSelect('user.photo', 'photo') // user.photo를 photo로 조인
      .leftJoinAndSelect('user.petkeywords', 'petkeywords') // user.petkeywords를 petkeywords로 조인
      .getManyAndCount();
    return result;
  }
  async getFollowerList(from_user_id: number): Promise<[Friends[], number]> {
    //from_user_id가 friend_user_id인 from_user_id조회
    const result = await this.createQueryBuilder('friends')
      .leftJoinAndSelect('friends.from_user_id', 'user') // friends.from_user_id를 user로 조인 (팔로워)
      .where('friends.friend_user_id = :from_user_id', {
        from_user_id: from_user_id,
      })
      .leftJoinAndSelect('user.photo', 'photo') // user와 photo 테이블 조인
      .leftJoinAndSelect('user.petkeywords', 'petkeywords') // user와 petkeywords 테이블 조인
      .getManyAndCount();
    return result;
  }
  async friendChecker(id: number, friend_user_id: number): Promise<boolean> {
    const result = await this.createQueryBuilder('friends')
      .leftJoinAndSelect('friends.friend_user_id', 'user')
      .where('friends.from_user_id = :fromUserId', {
        fromUserId: id,
      })
      .andWhere('user._id = :friendUserId', {
        friendUserId: friend_user_id,
      })
      .getOne();
    if (result) {
      return true;
    } else {
      return false;
    }
  }
  async deleteFriendRequest(id: number, friend_user_id: number): Promise<any> {
    const result = await this.createQueryBuilder('friends')
      .leftJoinAndSelect('friends.friend_user_id', 'user')
      .where('friends.from_user_id = :fromUserId', {
        fromUserId: id,
      })
      .andWhere('user._id = :friendUserId', {
        friendUserId: friend_user_id,
      })
      .getOne();
    return await this.delete({ _id: result._id });
  }
}
