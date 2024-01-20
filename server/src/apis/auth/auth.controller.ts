import { Controller, Get, Req, Res, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { Response } from 'express';
import { AuthService } from './auth.service';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}
  @Get('google')
  @UseGuards(AuthGuard('google'))
  async googleLogin(): Promise<void> {}

  @Get('google/callback')
  @UseGuards(AuthGuard('google'))
  async googleAuthCallback(@Req() req: any, @Res() res: Response) {
    const user = req.user;
    if (user) {
      this.authService.handleGoogleLogin(user, res);
    } else {
      const errorMessage =
        req.query.error_description || '구글 로그인에 실패했습니다.';
      res.status(400).json({ error: errorMessage });
    }
  }
}
