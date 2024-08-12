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
import { UsersService } from '../users/users.service';
import { JwtAuthGuard } from '../auth/jwt/jwt.guard';
import { Request } from 'express';
import { Payload } from '../auth/jwt/jwt.payload';

@UseGuards(JwtAuthGuard)
@Controller({ path: 'friends', version: '1' })
export class FriendsController {
  constructor(
    private readonly friendsService: FriendsService,
    private readonly usersService: UsersService,
  ) {}

  @Post('')
  async sendFriendRequest(@Req() req: Request, @Body() bodyData: any) {
    const userPayload = req.user as Payload;
    const result = await this.friendsService.sendFriendRequest(
      userPayload.user_id,
      bodyData.friend_user_id,
    );
    return result;
  }
  @Delete('')
  async deleteFriendRequest(@Req() req: Request, @Body() bodyData: any) {
    const userPayload = req.user as Payload;
    const result = await this.friendsService.deleteFriendRequest(
      userPayload.user_id,
      bodyData.friend_user_id,
    );
    return result;
  }

  @Get('follow')
  async getFollowList(@Req() req: Request) {
    const userPayload = req.user as Payload;
    const result = await this.friendsService.getFollowList(userPayload.user_id);
    return result;
  }

  @Get('follower')
  async getFollowerList(@Req() req: Request) {
    const userPayload = req.user as Payload;
    const result = await this.friendsService.getFollowerList(
      userPayload.user_id,
    );
    return result;
  }
}
