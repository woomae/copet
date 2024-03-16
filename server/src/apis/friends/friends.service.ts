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
    if (
      !friendRequestData.friend_user_id ||
      !friendRequestData.from_user_id ||
      friendRequestData.friend_user_id === friendRequestData.from_user_id
    )
      throw new BadRequestException('Invalid input friendsdata');
    if (await this.friendsRepository.friendChecker(friendRequestData)) {
      throw new BadRequestException('Already friend');
    }
    const userChecker = await this.friendsRepository.validUser(
      friendRequestData.friend_user_id,
    );
    if (!userChecker || userChecker.length === 0) {
      throw new BadRequestException(
        `Invalid input from_user_id ${friendRequestData.friend_user_id}`,
      );
    }
    //save
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
    const userChecker = await this.friendsRepository.validUser(
      bodyData.from_user_id,
    );
    if (!userChecker || userChecker.length === 0) {
      throw new BadRequestException(
        `Invalid input from_user_id ${bodyData.from_user_id}`,
      );
    }
    const friendList = await this.friendsRepository.getFollowList(
      bodyData.from_user_id,
    );
    const newfriendList = friendList.map((friend) => friend.friend_user_id);

    return newfriendList;
  }
  async getFollowerList(bodyData: Partial<Friends>): Promise<any> {
    const userChecker = await this.friendsRepository.validUser(
      bodyData.from_user_id,
    );
    if (!userChecker || userChecker.length === 0) {
      throw new BadRequestException(
        `Invalid input from_user_id ${bodyData.from_user_id}`,
      );
    }
    const friendList = await this.friendsRepository.getFollowerList(
      bodyData.from_user_id,
    );
    //follower들의 from_user_id만 리턴 추후 from_user_id로 유저정보를 가져와야함
    return friendList;
  }
}
