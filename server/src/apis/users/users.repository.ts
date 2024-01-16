import { Injectable } from '@nestjs/common';
import { Users } from './users.entity';
import { DataSource, Repository } from 'typeorm';

@Injectable()
export class UsersRepository extends Repository<Users> {
  constructor(dataSource: DataSource) {
    super(Users, dataSource.createEntityManager());
  }
  async findUser(options: any): Promise<Users> {
    return await this.findOne(options);
  }
  async createUser(user: Users) {
    return await this.save(user);
  }
  async findAll(): Promise<Users[]> {
    return await this.find();
  }
}
