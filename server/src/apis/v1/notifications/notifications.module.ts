import { Module } from '@nestjs/common';
import { NotificationsController } from './notifications.controller';
import { NotificationsService } from './notifications.service';
import { NotificationsRepository } from './notifications.repository';
import { UsersModule } from '../users/users.module';

@Module({
  controllers: [NotificationsController],
  providers: [NotificationsService, NotificationsRepository],
  imports: [UsersModule],
  exports: [NotificationsService],
})
export class NotificationsModule {}
