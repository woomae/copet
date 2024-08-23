import { Module } from '@nestjs/common';
import { FriendsController } from './friends.controller';
import { FriendsService } from './friends.service';
import { FriendsRepository } from './friends.repository';
import { UsersModule } from '../users/users.module';
import { NotificationsModule } from '../notifications/notifications.module';

@Module({
  controllers: [FriendsController],
  providers: [FriendsService, FriendsRepository],
  imports: [UsersModule, NotificationsModule],
})
export class FriendsModule {}
