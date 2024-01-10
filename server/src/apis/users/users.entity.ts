import { BaseEntity, Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity() // 이 부분이 추가되어야 함
export class Users extends BaseEntity {
  @PrimaryGeneratedColumn()
  _id: number;

  @Column()
  email: string;

  @Column()
  name: string;
}
