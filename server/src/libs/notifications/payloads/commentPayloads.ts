import { TokenMessage } from 'firebase-admin/lib/messaging/messaging-api';

export const commentPayloads: TokenMessage = {
  token: '',
  notification: {
    title: 'Copet🐶',
    body: ' 님이 회원님의 게시글에 댓글을 남겼습니다.',
  },
};
