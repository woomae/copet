import { BaseEntity, Column, PrimaryGeneratedColumn } from 'typeorm';

export class Article extends BaseEntity {
  @PrimaryGeneratedColumn()
  _id: number;

  @Column()
  title: string;

  @Column()
  description: string;
}
