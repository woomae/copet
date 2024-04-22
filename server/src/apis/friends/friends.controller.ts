import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { FriendsService } from './friends.service';
import { StandardResponseDto } from 'src/dto/standard-response.dto';
import { Friends } from './friends.entity';

@Controller('friends')
export class FriendsController {
  constructor(private readonly friendsService: FriendsService) {}

  @Post('friend-request')
  async sendFriendRequest(
    @Body() friendRequestData: Partial<Friends>,
  ): Promise<StandardResponseDto> {
    const result =
      await this.friendsService.sendFriendRequest(friendRequestData);
    return new StandardResponseDto(201, 'api.common.created', result);
  }

  @Get(':id')
  async getFriends(@Param('id') id: number): Promise<StandardResponseDto> {
    const result = await this.friendsService.getFriends(id);
    return new StandardResponseDto(200, 'api.common.success', result);
  }
}
