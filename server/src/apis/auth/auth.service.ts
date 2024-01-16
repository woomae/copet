import { Injectable } from '@nestjs/common';
import { UsersService } from '../users/users.service';
import { ConfigService } from '@nestjs/config';
import { error } from 'console';

@Injectable()
export class AuthService {
  constructor(
    private readonly usersService: UsersService,
    private readonly configservice: ConfigService,
  ) {}
  async handleGoogleLogin(GoogleUser: any, res: any): Promise<void> {
    const { email } = GoogleUser;
    let user = await this.usersService.findUser({
      where: { email: email },
    });
    if (!user) {
      user = await this.usersService.createUser(GoogleUser);
    }
    const usercookie = JSON.stringify({
      email: user.email,
      name: user.name,
    });
    const redirectUrl = this.configservice.get('REDIRECT_URL');
    const rooturl = this.configservice.get('ROOT_URL');
    if (redirectUrl) {
      res
        .cookie('user', usercookie, {
          sameSite: 'lax',
          path: '/',
          httpOnly: true,
          expires: new Date(Date.now() + 5 * 24 * 60 * 60 * 1000), // 만료기간 5일
          domain: rooturl,
        })
        .redirect(redirectUrl);
      console.log('redirectdone!');
    } else {
      error('Redirect URL is not defined');
    }
  }

  googleLogin(req: Request): any {
    if (!req) return 'No user from google';
  }
}
