import {
  BaseEntity,
  Column,
  CreateDateColumn,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { Users } from '../users/users.entity';
import { Exclude } from 'class-transformer';

@Entity()
export class Friends {
  @PrimaryGeneratedColumn()
  _id: number;

  @ManyToOne(() => Users, (user) => user._id, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'friend_user_id' })
  friend_user_id: number;

  @ManyToOne(() => Users, (user) => user._id, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'from_user_id' })
  from_user_id: number;

  @Exclude({ toPlainOnly: true })
  @CreateDateColumn({
    type: 'timestamptz',
  })
  created_at: Date;

  @Exclude({ toPlainOnly: true })
  @UpdateDateColumn({
    type: 'timestamptz',
  })
  updated_at: Date;
}
