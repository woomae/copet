import { Body, Controller, Delete, Get, Post } from '@nestjs/common';
import { FriendsService } from './friends.service';
import { StandardResponseDto } from 'src/dto/standard-response.dto';
import { Friends } from './friends.entity';
import { UsersService } from '../users/users.service';
import ApiCodes from 'src/common/api.codes';
import ApiMessages from 'src/common/api.messages';

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
      response = new StandardResponseDto(
        ApiCodes.CREATED,
        ApiMessages.CREATED,
        result,
      );
    } catch (error) {
      response = new StandardResponseDto(
        error.response.statusCode,
        error.response.message,
        null,
      );
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
      response = new StandardResponseDto(ApiCodes.OK, ApiMessages.OK, result);
    } catch (error) {
      response = new StandardResponseDto(
        error.response.statusCode,
        error.response.message,
        null,
      );
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
      response = new StandardResponseDto(ApiCodes.OK, ApiMessages.OK, result);
    } catch (error) {
      response = new StandardResponseDto(
        error.response.statusCode,
        error.response.message,
        null,
      );
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
      response = new StandardResponseDto(ApiCodes.OK, ApiMessages.OK, result);
    } catch (error) {
      response = new StandardResponseDto(
        error.response.statusCode,
        error.response.message,
        null,
      );
    }
    return response;
  }
}
