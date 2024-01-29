import { Body, Controller, Param, Post } from '@nestjs/common';
import { FriendsService } from './friends.service';
import { StandardResponseDto } from 'src/dto/standard-response.dto';
import { Friends } from './friends.entity';

@Controller('friends')
export class FriendsController {
  constructor(private readonly friendsService: FriendsService) {}

  @Post(':id/friend-request')
  async sendFriendRequest(
    @Param('id') id: number,
    @Body() friendRequestData: Partial<Friends>,
  ): Promise<StandardResponseDto> {
    const result = await this.friendsService.sendFriendRequest(
      id,
      friendRequestData,
    );
    return new StandardResponseDto(201, 'api.common.created', result);
  }
}
