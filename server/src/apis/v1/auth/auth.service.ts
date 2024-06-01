import { Injectable } from '@nestjs/common';
import { UsersService } from '../users/users.service';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import { Users } from '../users/users.entity';
import { Payload } from './jwt/jwt.payload';

@Injectable()
export class AuthService {
  constructor(
    private readonly jwtService: JwtService,
    private readonly env: ConfigService,
  ) {}

  createPayload(users: Users): Payload {
    return {
      provider_id: users?.provider_id,
      email: users?.email,
      user_id: users?._id,
    };
  }

  signToken(payload: Payload): string {
    return this.jwtService.sign(payload, {
      expiresIn: this.env.get<string>('JWT_EXPIRES_IN'),
    });
  }

  getCookie(name: string, value: string, options: Record<string, any> = {}) {
    return {
      [name]: {
        value,
        options: {
          ...options,
          httpOnly: true,
          domain: this.env.get<string>('COOKIE_DOMAIN'),
        },
      },
    };
  }
}
