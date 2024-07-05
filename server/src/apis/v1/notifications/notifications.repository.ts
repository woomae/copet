import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { Notifications } from './notification.entity';

@Injectable()
export class NotificationsRepository extends Repository<Notifications> {
  constructor(dataSource: DataSource) {
    super(Notifications, dataSource.createEntityManager());
  }
  async getNotifications(user_id: number) {
    const result = await this.createQueryBuilder('notifications')
      .where('notifications.user_id = :user_id', { user_id: user_id })
      .getMany();
    return result;
  }
}
