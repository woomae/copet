import {
  Controller,
  Delete,
  Get,
  Param,
  Query,
  Req,
  UseGuards,
} from '@nestjs/common';
import { NotificationsService } from './notifications.service';
import { JwtAuthGuard } from '../auth/jwt/jwt.guard';
import { Payload } from '../auth/jwt/jwt.payload';
import { User } from 'src/common/decorators/user.decorator';
import { getNotificationQueryDto } from 'src/dto/getNotificationQuery.dto';

@UseGuards(JwtAuthGuard)
@Controller({ path: 'notifications', version: '1' })
export class NotificationsController {
  constructor(private readonly notificationService: NotificationsService) {}

  @Get('')
  async getnotifications(
    @User() user: Payload,
    @Query() query: getNotificationQueryDto,
  ) {
    const result = await this.notificationService.getNotifications(
      user.user_id,
      query,
    );
    return result;
  }
  @Delete(':id')
  async deleteNotification(@Param('id') id: number) {
    const result = await this.notificationService.deleteNotification(id);
    return result;
  }
}
