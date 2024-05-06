import {
  Body,
  Controller,
  Delete,
  Get,
  Post,
  UseInterceptors,
} from '@nestjs/common';
import { FriendsService } from './friends.service';
import { StandardResponseDto } from 'src/dto/standard-response.dto';
import { Friends } from './friends.entity';
import { UsersService } from '../users/users.service';
import ResponseFormat from 'src/common/response-format';
import { LoggingInterceptor } from 'src/common/logger/logger.intrecepter';

@Controller('friends')
export class FriendsController {
  constructor(
    private readonly friendsService: FriendsService,
    private readonly usersService: UsersService,
  ) {}

  @Post('friend-request')
  @UseInterceptors(LoggingInterceptor)
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
  @UseInterceptors(LoggingInterceptor)
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
  @UseInterceptors(LoggingInterceptor)
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
  @UseInterceptors(LoggingInterceptor)
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
