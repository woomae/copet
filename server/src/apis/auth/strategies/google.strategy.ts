import { Injectable } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { Strategy } from 'passport-google-oauth20';

@Injectable()
export class GoogleStrategy extends PassportStrategy(Strategy, 'google') {
  constructor() {
    super({
      clientID: '클라이언트 ID', // CLIENT_ID
      clientSecret: '클라이언트 보안 비밀번호', // CLIENT_SECRET
      callbackURL: '리디렉트 URI', // redirect_uri
      passReqToCallback: true,
      scope: ['email', 'profile'], // 가져올 정보들
    });
  }

  async validate(
    accessToken: string,
    refreshToken: string,
    profile: any,
    done: any,
  ): Promise<any> {
    try {
      const { name, emails } = profile;
      const user = {
        email: emails[0].value,
        name: name.givenName,
        accessToken,
      };
      done(null, user);
    } catch (error) {
      done(error);
    }
  }
}
