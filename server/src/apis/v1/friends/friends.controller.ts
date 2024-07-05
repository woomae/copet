import {
  Body,
  Controller,
  Delete,
  Get,
  Post,
  Req,
  UseGuards,
} from '@nestjs/common';
import { FriendsService } from './friends.service';
import { JwtAuthGuard } from '../auth/jwt/jwt.guard';
import { Request } from 'express';
import { Payload } from '../auth/jwt/jwt.payload';
import { User } from 'src/common/decorators/user.decorator';

@UseGuards(JwtAuthGuard)
@Controller({ path: 'friends', version: '1' })
export class FriendsController {
  constructor(private readonly friendsService: FriendsService) {}

  @Post('')
  async sendFriendRequest(@User() user: Payload, @Body() bodyData: any) {
    const result = await this.friendsService.sendFriendRequest(
      user.user_id,
      bodyData.friend_user_id,
    );
    return result;
  }
  @Delete('')
  async deleteFriendRequest(@User() user: Payload, @Body() bodyData: any) {
    const result = await this.friendsService.deleteFriendRequest(
      user.user_id,
      bodyData.friend_user_id,
    );
    return result;
  }

  @Get('follow')
  async getFollowList(@User() user: Payload) {
    const result = await this.friendsService.getFollowList(user.user_id);
    return result;
  }

  @Get('follower')
  async getFollowerList(@User() user: Payload) {
    const result = await this.friendsService.getFollowerList(user.user_id);
    return result;
  }
}
