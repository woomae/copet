import {
  //stars로 맞춰서 수정할것
  BaseEntity,
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
  ManyToOne,
  JoinColumn,
} from 'typeorm';
import { Users } from '../users/users.entity';

@Entity()
export class Stars extends BaseEntity {
  @PrimaryGeneratedColumn()
  _id: number;

  @Column()
  article_id: number;

  @ManyToOne(() => Users, (user) => user._id, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'clicked_user_id' })
  clicked_user_id: number;

  @CreateDateColumn({
    type: 'timestamptz',
  })
  created_at: Date;

  @UpdateDateColumn({
    type: 'timestamptz',
  })
  updated_at: Date;
}
