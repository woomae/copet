import { Injectable } from '@nestjs/common';
import { UsersService } from '../users/users.service';
import { Response } from 'express';
import { ConfigService } from '@nestjs/config';
import { error } from 'console';

@Injectable()
export class AuthService {
  constructor(
    private readonly usersService: UsersService,
    private readonly configservice: ConfigService,
  ) {}
  async handleGoogleLogin(GoogleUser: any, res: Response): Promise<void> {
    const { email } = GoogleUser;
    let user = await this.usersService.findUserByEmail(email);
    if (!user) {
      user = await this.usersService.createUser(GoogleUser);
    }
    const usercookie = JSON.stringify({
      user_id: user._id,
      email: user.email,
      name: user.nickname,
    });
    const redirectUrl = this.configservice.get('REDIRECT_URL');
    const rooturl = this.configservice.get('ROOT_URL');
    if (redirectUrl) {
      res
        .cookie('user', usercookie, {
          path: '/',
          expires: new Date(Date.now() + 5 * 24 * 60 * 60 * 1000), // 만료기간 5일
          domain: rooturl,
        })
        .redirect(redirectUrl);
    } else {
      error('Redirect URL is not defined');
    }
  }

  async handleKakaoLogin(kakaoUser: any, res: Response): Promise<void> {
    const { email } = kakaoUser;
    kakaoUser.nickname = kakaoUser.name;
    let user = await this.usersService.findUserByEmail(email);
    if (!user) {
      user = await this.usersService.createUser(kakaoUser);
    }
    const usercookie = JSON.stringify({
      user_id: user._id,
      email: user.email,
      name: user.nickname,
    });
    const redirectUrl = this.configservice.get('REDIRECT_URL');
    const rooturl = this.configservice.get('ROOT_URL');
    if (redirectUrl) {
      res
        .cookie('user', usercookie, {
          path: '/',
          expires: new Date(Date.now() + 5 * 24 * 60 * 60 * 1000), // 만료기간 5일
          domain: rooturl,
        })
        .redirect(redirectUrl);
    } else {
      error('Redirect URL is not defined');
    }
  }
}
