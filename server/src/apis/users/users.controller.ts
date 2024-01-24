import { Body, Controller, Get, Param, Put } from '@nestjs/common';
import { Users } from './users.entity';
import { UsersService } from './users.service';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}
  @Get('/')
  async getAllUsers(): Promise<Users[]> {
    return this.usersService.findAll(); //수정 필요 보안적으로 위험 및 필요없음(테스트용)
  }
  @Put('/init/:id')
  async initUser(
    @Param('id') id: number,
    @Body() updatedUser: Partial<Users>,
  ): Promise<Users> {
    return this.usersService.initUser(id, updatedUser);
  }
}
