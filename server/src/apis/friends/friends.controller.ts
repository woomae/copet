import { Body, Controller, Delete, Get, Post } from '@nestjs/common';
import { FriendsService } from './friends.service';
import { StandardResponseDto } from 'src/dto/standard-response.dto';
import { Friends } from './friends.entity';
import { UsersService } from '../users/users.service';
import ResponseFormat from 'src/common/response-format';

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
    let result;
    let response;
    try {
      result = await this.friendsService.sendFriendRequest(friendRequestData);
      response = ResponseFormat.ok(result).format();
    } catch (error) {
      response = ResponseFormat.fail(error).format();
    }
    return response;
  }
  @Delete('friend-request')
  async deleteFriendRequest(
    @Body() friendRequestData: Partial<Friends>,
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.friendsService.deleteFriendRequest(friendRequestData);
      response = ResponseFormat.ok(result).format();
    } catch (error) {
      response = ResponseFormat.fail(error).format();
    }
    return response;
  }

  @Get('follow')
  async getFollowList(
    @Body() bodyData: Partial<Friends>,
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      result = await this.friendsService.getFollowList(bodyData);
      response = ResponseFormat.ok(result).format();
    } catch (error) {
      response = ResponseFormat.fail(error).format();
    }
    return response;
  }

  @Get('follower')
  async getFollowerList(
    @Body() bodyData: Partial<Friends>,
  ): Promise<StandardResponseDto> {
    let result;
    let response;
    try {
      const followerList = await this.friendsService.getFollowerList(bodyData);
      result = await this.usersService.getFollowerInfo(followerList);
      response = ResponseFormat.ok(result).format();
    } catch (error) {
      response = ResponseFormat.fail(error).format();
    }
    return response;
  }
}
