import { Injectable } from '@nestjs/common';
import * as admin from 'firebase-admin';
import { InjectRepository } from '@nestjs/typeorm';
import { Notifications } from './notification.entity';
import { TokenMessage } from 'firebase-admin/lib/messaging/messaging-api';
import { NotificationsRepository } from './notifications.repository';
import { UsersService } from '../users/users.service';
import { getNotificationQueryDto } from 'src/dto/getNotificationQuery.dto';
import ApiError from 'src/libs/res/api.errors';
import ApiCodes from 'src/libs/res/api.codes';
import ApiMessages from 'src/libs/res/api.messages';

@Injectable()
export class NotificationsService {
  constructor(
    @InjectRepository(NotificationsRepository)
    private readonly notificationsRepository: NotificationsRepository,
    private readonly usersService: UsersService,
  ) {
    admin.initializeApp({
      credential: admin.credential.cert({
        projectId: process.env.FIREBASE_PROJECT_ID,
        clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
        privateKey: process.env.FIREBASE_PRIVATE_KEY.replace(/\\n/g, '\n'),
      }),
    });
  }
  async sendNotification(
    receiveUser: number,
    requestUser: number,
    payload: TokenMessage,
  ) {
    //유저 닉네임, token 불러오기
    payload.token = (
      await this.usersService.findUserById(receiveUser)
    ).firebase_token;
    const nickname = (await this.usersService.findUserById(requestUser))
      .nickname;
    payload.notification.body = nickname + payload.notification.body;

    const result = await admin
      .messaging()
      .send(payload)
      .then(async (response) => {
        // 알림 정보를 데이터베이스에 저장
        const notification = new Notifications();
        notification.firebase_token = payload.token;
        notification.title = payload.notification.title;
        notification.body = payload.notification.body;

        await this.notificationsRepository.save(notification);

        return { sent_message: response };
      });
    return result;
  }
  async getNotifications(user_id: number, query: getNotificationQueryDto) {
    const result = await this.notificationsRepository.getNotifications(
      user_id,
      query.page,
      query.size,
    );
    return result;
  }
  async deleteNotification(notificationId: number) {
    //하나 조회해서 본인거 맞느지 확인
    const notificaton = await this.notificationsRepository.findOneBy({
      _id: notificationId,
    });
    if (!notificaton) {
      throw new ApiError(ApiCodes.NOT_FOUND, ApiMessages.NOT_FOUND, {
        message: '알림을 찾을 수 없습니다.',
      });
    }
    const result = await this.notificationsRepository.delete({
      _id: notificationId,
    });
    return result;
  }
}
