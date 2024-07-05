import { TokenMessage } from 'firebase-admin/lib/messaging/messaging-api';

export const starPayloads: TokenMessage = {
  token: '',
  notification: {
    title: 'Copet🐶',
    body: ' 님이 회원님의 게시글을 스크랩 했습니다.',
  },
};
