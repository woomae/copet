import { Body, Controller, Get, Post } from '@nestjs/common';
import { FriendsService } from './friends.service';
import { StandardResponseDto } from 'src/dto/standard-response.dto';
import { Friends } from './friends.entity';
import { UsersService } from '../users/users.service';

@Controller('friends')
export class FriendsController {
  constructor(
    private readonly friendsService: FriendsService,
    private readonly usersService: UsersService,
  ) {}

  @Post('friend-request')
  async sendFriendRequest(
    @Body() friendRequestData: Partial<Friends>,
  ): Promise<StandardResponseDto> {
    const result =
      await this.friendsService.sendFriendRequest(friendRequestData);
    if (!result) {
      return new StandardResponseDto(200, 'api.common.ok', result);
    }
    return new StandardResponseDto(201, 'api.common.created', result);
  }

  @Get('follow')
  async getFollowList(
    @Body() bodyData: Partial<Friends>,
  ): Promise<StandardResponseDto> {
    const result = await this.friendsService.getFollowList(bodyData);
    return new StandardResponseDto(200, 'api.common.ok', result);
  }

  @Get('follower')
  async getFollowerList(
    @Body() bodyData: Partial<Friends>,
  ): Promise<StandardResponseDto> {
    const followerList = await this.friendsService.getFollowerList(bodyData);
    const result = await this.usersService.getFollowerInfo(followerList);
    return new StandardResponseDto(200, 'api.common.ok', result);
  }
}
