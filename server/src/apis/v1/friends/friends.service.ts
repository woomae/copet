import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { FriendsRepository } from './friends.repository';
import { Friends } from './friends.entity';
import { UsersService } from '../users/users.service';

@Injectable()
export class FriendsService {
  constructor(
    @InjectRepository(FriendsRepository)
    private friendsRepository: FriendsRepository,
    private usersService: UsersService,
  ) {}
  async sendFriendRequest(
    friendRequestData: Partial<Friends>,
  ): Promise<Friends> {
    if (
      !friendRequestData.friend_user_id ||
      !friendRequestData.from_user_id ||
      friendRequestData.friend_user_id === friendRequestData.from_user_id
    )
      throw new BadRequestException('Invalid input friendsdata');
    if (await this.friendsRepository.friendChecker(friendRequestData)) {
      throw new BadRequestException('Already friend');
    }
    await this.usersService.findUserById(friendRequestData.friend_user_id);
    await this.usersService.findUserById(friendRequestData.from_user_id);
    return await this.friendsRepository.createFriendRequest(friendRequestData);
  }
  async deleteFriendRequest(
    friendRequestData: Partial<Friends>,
  ): Promise<Friends> {
    if (
      !friendRequestData.friend_user_id ||
      !friendRequestData.from_user_id ||
      friendRequestData.friend_user_id === friendRequestData.from_user_id
    )
      throw new BadRequestException('Invalid input friendsdata');
    if (!(await this.friendsRepository.friendChecker(friendRequestData))) {
      throw new BadRequestException('Not friend');
    }
    //delete
    return await this.friendsRepository.deleteFriendRequest(friendRequestData);
  }
  async getFollowList(bodyData: Partial<Friends>): Promise<any> {
    await this.usersService.findUserById(bodyData.from_user_id);
    const friendList = await this.friendsRepository.getFollowList(
      bodyData.from_user_id,
    );
    const newfriendList = friendList[0].map((friend) => friend.friend_user_id);
    const friendListCount = { count: friendList[1] };
    return [friendListCount, newfriendList];
  }
  async getFollowerList(bodyData: Partial<Friends>): Promise<any> {
    await this.usersService.findUserById(bodyData.from_user_id);
    const friendList = await this.friendsRepository.getFollowerList(
      bodyData.from_user_id,
    );
    const friendListCount = { count: friendList[1] };
    //follower들의 from_user_id만 리턴 추후 from_user_id로 유저정보를 가져와야함
    return [friendListCount, friendList[0]];
  }
}
