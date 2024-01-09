import { Injectable } from '@nestjs/common';
import { UsersService } from '../users/users.service';

@Injectable()
export class AuthService {
  constructor(private readonly usersService: UsersService) {}
  async handleGoogleLogin(GoogleUser: any, res: any): Promise<void> {
    const { email } = GoogleUser;
    let user = await this.usersService.findOne({
      where: { email: email },
    });
    if (!user) {
      user = await this.usersService.createUser(GoogleUser);
    }
  }

  googleLogin(req: Request): any {
    if (!req) return 'No user from google';
  }
}
