import { Controller, Get, Header, Req, Res, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { Request, Response } from 'express';
import { AuthService } from './auth.service';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}
  @Get('google')
  @Header('Content-Type', 'application/x-www-form-urlencoded;charset=utf-8')
  @UseGuards(AuthGuard('google'))
  async googleLogin(): Promise<void> {}

  @Get('google/callback')
  @UseGuards(AuthGuard('google'))
  async googleAuthCallback(
    @Req() req: Request & { user?: any },
    @Res() res: Response,
  ) {
    const user = req.user;
    if (user) {
      this.authService.handleGoogleLogin(user, res);
    } else {
      const errorMessage =
        req.query.error_description || '구글 로그인에 실패했습니다.';
      res.status(400).json({ error: errorMessage });
    }
  }

  @Get('kakao')
  @Header('Content-Type', 'application/x-www-form-urlencoded;charset=utf-8')
  @UseGuards(AuthGuard('kakao'))
  async kakaoLogin(): Promise<void> {}

  @Get('kakao/callback')
  @UseGuards(AuthGuard('kakao'))
  async kakaoAuthCallback(
    @Req() req: Request & { user?: any },
    @Res() res: Response,
  ) {
    const user = req.user;
    if (user) {
      this.authService.handleKakaoLogin(user, res);
    } else {
      const errorMessage =
        req.query.error_description || '카카오 로그인에 실패했습니다.';
      res.status(400).json({ error: errorMessage });
    }
  }
}
