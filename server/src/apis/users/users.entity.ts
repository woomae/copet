import { BaseEntity, Column, PrimaryGeneratedColumn } from 'typeorm';

export class Users extends BaseEntity {
  @PrimaryGeneratedColumn()
  _id: number;

  @Column()
  email: string;

  @Column()
  name: string;
}
//entity 수정 필요
