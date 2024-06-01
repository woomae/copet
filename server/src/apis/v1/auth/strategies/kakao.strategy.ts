import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PassportStrategy } from '@nestjs/passport';
import { Profile, Strategy } from 'passport-kakao';
import { UsersService } from '../../users/users.service';
import { CallBackUserDataDto } from 'src/dto/callback-user.dto';

@Injectable()
export class KakaoStrategy extends PassportStrategy(Strategy, 'kakao') {
  constructor(
    private readonly env: ConfigService,
    private readonly usersService: UsersService,
  ) {
    super({
      clientID: env.get<string>('KAKAO_API_KEY'),
      clientSecret: env.get<string>('KAKAO_CLIENT_SECRET'),
      callbackURL: env.get<string>('KAKAO_CALLBACK_URL'),
    });
  }

  async validate(
    accessToken: string,
    refreshToken: string,
    profile: Profile,
    done,
  ) {
    const { id, _json } = profile;
    const userData: CallBackUserDataDto = {
      provider_id: id,
      email: _json.kakao_account.email,
    };
    const user = await this.usersService.findOneByProviderId(
      userData.provider_id,
    );
    if (!user) {
      const newUser = await this.usersService.createUser(userData);
      return done(null, newUser);
    }
    done(null, user);
  }
}
