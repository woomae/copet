import { Injectable } from '@nestjs/common';
import { Users } from './users.entity';
import { DataSource, Repository } from 'typeorm';

@Injectable()
export class UsersRepository extends Repository<Users> {
  constructor(dataSource: DataSource) {
    super(Users, dataSource.createEntityManager());
  }
  async findOne(options: any) {
    return await this.findOneBy(options);
  }
  async createUser(user: Users) {
    return await this.save(user);
  }
  async findAll() {
    return await this.find();
  }
}
