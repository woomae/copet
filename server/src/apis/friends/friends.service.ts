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
    id: number,
    friendRequestData: Partial<Friends>,
  ): Promise<Friends> {
    if (!friendRequestData.friend_user_id || !friendRequestData.from_user_id)
      throw new BadRequestException('Invalid input friendsdata');
    //save
    return await this.friendsRepository.createFriendRequest(friendRequestData);
  }
}
