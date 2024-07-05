import { Controller, Get, Req, UseGuards } from '@nestjs/common';
import { NotificationsService } from './notifications.service';
import { JwtAuthGuard } from '../auth/jwt/jwt.guard';
import { Request } from 'express';
import { Payload } from '../auth/jwt/jwt.payload';
import { User } from 'src/common/decorators/user.decorator';

@UseGuards(JwtAuthGuard)
@Controller({ path: 'notifications', version: '1' })
export class NotificationsController {
  constructor(private readonly notificationService: NotificationsService) {}

  @Get('')
  async getnotifications(@User() user: Payload) {
    const result = await this.notificationService.getNotifications(
      user.user_id,
    );
    return result;
  }
}
