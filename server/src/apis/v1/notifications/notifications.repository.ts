import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { Notifications } from './notification.entity';

@Injectable()
export class NotificationsRepository extends Repository<Notifications> {
  constructor(dataSource: DataSource) {
    super(Notifications, dataSource.createEntityManager());
  }
  async getNotifications(user_id: number, page: number, size: number) {
    const queryBuilder = this.createQueryBuilder('notifications')
      .where('notifications.user_id = :user_id', { user_id: user_id })
      .take(size)
      .skip((page - 1) * size);
    const [notifications, total] = await queryBuilder.getManyAndCount();
    return { total, notifications: notifications };
  }
}
