import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { FriendsRepository } from './friends.repository';
import { Friends } from './friends.entity';
import { UsersService } from '../users/users.service';
import ApiError from 'src/libs/res/api.errors';
import ApiCodes from 'src/libs/res/api.codes';
import ApiMessages from 'src/libs/res/api.messages';

@Injectable()
export class FriendsService {
  constructor(
    @InjectRepository(FriendsRepository)
    private friendsRepository: FriendsRepository,
    private usersService: UsersService,
  ) {}
  async sendFriendRequest(
    id: number,
    friend_user_id: number,
  ): Promise<Friends> {
    if (await this.friendsRepository.friendChecker(id, friend_user_id)) {
      throw new ApiError(ApiCodes.BAD_REQUEST, ApiMessages.BAD_REQUEST, {
        message: 'Already friend',
      });
    }
    return await this.friendsRepository.createFriendRequest(id, friend_user_id);
  }
  async deleteFriendRequest(
    id: number,
    friend_user_id: number,
  ): Promise<Friends> {
    if (!(await this.friendsRepository.friendChecker(id, friend_user_id))) {
      throw new ApiError(ApiCodes.BAD_REQUEST, ApiMessages.BAD_REQUEST, {
        message: 'Not friend',
      });
    }
    return await this.friendsRepository.deleteFriendRequest(id, friend_user_id);
  }
  async getFollowList(user_id: number): Promise<any> {
    const friendList = await this.friendsRepository.getFollowList(user_id);
    const newfriendList = friendList[0].map((friend) => friend.friend_user_id);
    const friendListCount = { count: friendList[1] };
    return [friendListCount, newfriendList];
  }
  async getFollowerList(user_id: number): Promise<any> {
    const friendList = await this.friendsRepository.getFollowerList(user_id);
    const newfriendList = friendList[0].map((friend) => friend.from_user_id);
    const friendListCount = { count: friendList[1] };
    return [friendListCount, newfriendList];
  }
}
