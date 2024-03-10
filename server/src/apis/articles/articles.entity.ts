import {
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
export class Articles extends BaseEntity {
  @PrimaryGeneratedColumn()
  _id: number;

  @Column({ generated: 'increment' })
  article_id: number;

  @Column()
  author: string;

  @Column()
  title: string;

  @Column()
  body: string;

  @Column()
  category: string;

  @Column({ nullable: true })
  img_name: string;

  @Column({ default: 0 })
  comment_count: number;

  @Column({ default: 0 })
  scrap_count: number;

  @Column({ default: 0 })
  complain_count: number;

  @ManyToOne(() => Users, (user) => user._id)
  @JoinColumn({ name: 'owner_id' })
  owner_id: number;

  @CreateDateColumn({
    type: 'timestamptz',
  })
  created_at: Date;

  @UpdateDateColumn({
    type: 'timestamptz',
  })
  updated_at: Date;
}
