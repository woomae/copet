import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { UsersService } from '../../users/users.service';
import ApiError from 'src/libs/res/api.errors';
import ApiCodes from 'src/libs/res/api.codes';
import ApiMessages from 'src/libs/res/api.messages';
import { Request } from 'express';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(
    private readonly env: ConfigService,
    private readonly userService: UsersService,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromExtractors([
        (request: Request) => {
          const token = request?.cookies?.user;
          if (!token) {
            throw new ApiError(
              ApiCodes.UNAUTHORIZED,
              ApiMessages.UNAUTHORIZED,
              {
                message: 'No authentication token found in cookies',
              },
            );
          }
          return token;
        },
      ]),
      ignoreExpiration: false,
      secretOrKey: env.get<string>('JWT_SECRET'),
    });
  }

  async validate(payload: any) {
    const user = await this.userService.findOneByProviderId(payload.providerId);
    if (!user) {
      throw new ApiError(ApiCodes.UNAUTHORIZED, ApiMessages.UNAUTHORIZED);
    }
    return payload;
  }
}
