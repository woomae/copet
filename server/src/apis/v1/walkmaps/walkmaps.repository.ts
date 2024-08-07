import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { Walkmaps } from './walkmaps.entity';

@Injectable()
export class WalkmapsRepository extends Repository<Walkmaps> {
  constructor(dataSource: DataSource) {
    super(Walkmaps, dataSource.createEntityManager());
  }
  async createWalkmap(walkmap: Walkmaps) {
    return await this.save(walkmap);
  }
}
