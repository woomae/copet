import { TokenMessage } from 'firebase-admin/lib/messaging/messaging-api';

export const friendPayloads: TokenMessage = {
  token: '',
  notification: {
    title: 'Copet🐶',
    body: ' 님이 회원을 팔로우 합니다.',
  },
};
