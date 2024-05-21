import {
  Body,
  Controller,
  Delete,
  Get,
  Post,
  UseInterceptors,
} from '@nestjs/common';
import { FriendsService } from './friends.service';
import { Friends } from './friends.entity';
import { UsersService } from '../users/users.service';
import { LoggingInterceptor } from 'src/libs/logger/logger.intrecepter';

@Controller('friends')
export class FriendsController {
  constructor(
    private readonly friendsService: FriendsService,
    private readonly usersService: UsersService,
  ) {}

  @Post('friend-request')
  @UseInterceptors(LoggingInterceptor)
  async sendFriendRequest(@Body() friendRequestData: Partial<Friends>) {
    const result =
      await this.friendsService.sendFriendRequest(friendRequestData);
    return result;
  }
  @Delete('friend-request')
  @UseInterceptors(LoggingInterceptor)
  async deleteFriendRequest(@Body() friendRequestData: Partial<Friends>) {
    const result =
      await this.friendsService.deleteFriendRequest(friendRequestData);
    return result;
  }

  @Get('follow')
  @UseInterceptors(LoggingInterceptor)
  async getFollowList(@Body() bodyData: Partial<Friends>) {
    const result = await this.friendsService.getFollowList(bodyData);
    return result;
  }

  @Get('follower')
  @UseInterceptors(LoggingInterceptor)
  async getFollowerList(@Body() bodyData: Partial<Friends>) {
    const followerList = await this.friendsService.getFollowerList(bodyData);
    const result = await this.usersService.getFollowerInfo(followerList);
    return result;
  }
}
