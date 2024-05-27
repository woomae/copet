import { Body, Controller, Delete, Get, Post } from '@nestjs/common';
import { FriendsService } from './friends.service';
import { Friends } from './friends.entity';
import { UsersService } from '../users/users.service';

@Controller('friends')
export class FriendsController {
  constructor(
    private readonly friendsService: FriendsService,
    private readonly usersService: UsersService,
  ) {}

  @Post('')
  async sendFriendRequest(@Body() friendRequestData: Partial<Friends>) {
    const result =
      await this.friendsService.sendFriendRequest(friendRequestData);
    return result;
  }
  @Delete('')
  async deleteFriendRequest(@Body() friendRequestData: Partial<Friends>) {
    const result =
      await this.friendsService.deleteFriendRequest(friendRequestData);
    return result;
  }

  @Get('follow')
  async getFollowList(@Body() bodyData: Partial<Friends>) {
    const result = await this.friendsService.getFollowList(bodyData);
    return result;
  }

  @Get('follower')
  async getFollowerList(@Body() bodyData: Partial<Friends>) {
    const followerList = await this.friendsService.getFollowerList(bodyData);
    const result = await this.usersService.getFollowerInfo(followerList);
    return result;
  }
}
