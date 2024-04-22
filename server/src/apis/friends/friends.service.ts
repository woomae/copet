import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { FriendsRepository } from './friends.repository';
import { Friends } from './friends.entity';

@Injectable()
export class FriendsService {
  constructor(
    @InjectRepository(FriendsRepository)
    private friendsRepository: FriendsRepository,
  ) {}
  async sendFriendRequest(
    friendRequestData: Partial<Friends>,
  ): Promise<Friends> {
    if (!friendRequestData.friend_user_id || !friendRequestData.from_user_id)
      throw new BadRequestException('Invalid input friendsdata');
    if (await this.friendsRepository.friendChecker(friendRequestData))
      throw new BadRequestException('data already exists');
    //save
    return await this.friendsRepository.createFriendRequest(friendRequestData);
  }
  async getFriends(id: number): Promise<any> {
    const friendList = await this.friendsRepository.getFriendsList(id);
    const result = friendList.map((item) => item.friend_user_id);
    return result;
  }
}
