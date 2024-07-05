import { Exclude } from 'class-transformer';
import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
} from 'typeorm';

@Entity()
export class Notifications {
  @PrimaryGeneratedColumn()
  _id: number;

  @Exclude({ toPlainOnly: true })
  @Column()
  firebase_token: string;

  @Column()
  title: string;

  @Column()
  body: string;

  @CreateDateColumn({
    type: 'timestamptz',
  })
  created_at: Date;
}
