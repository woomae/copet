import { Body, Controller, Get, Post, Req, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { Request, Response } from 'express';
import { AuthService } from './auth.service';
import { UsersService } from '../users/users.service';
import { Users } from '../users/users.entity';
import { Payload } from './jwt/jwt.payload';
import { JwtAuthGuard } from './jwt/jwt.guard';

@Controller({ path: 'auth', version: '1' })
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Get('kakao')
  @UseGuards(AuthGuard('kakao'))
  async kakaoLogin(): Promise<void> {}

  @Get('kakao/callback')
  @UseGuards(AuthGuard('kakao'))
  async kakaoLoginCallBack(@Req() req: Request) {
    const user = req.user as Users;

    const payload: Payload = this.authService.createPayload(user);

    const accessToken = this.authService.signToken(payload);

    return {
      cookies: this.authService.getCookie('user', accessToken),
    };
  }
  @Post('logout')
  @UseGuards(JwtAuthGuard)
  async logout() {
    return {
      cookies: this.authService.getCookie('user', ''),
    };
  }
}
