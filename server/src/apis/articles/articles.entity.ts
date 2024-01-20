import {
  BaseEntity,
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
  OneToOne,
  JoinColumn,
} from 'typeorm';
import { Users } from '../users/users.entity';

@Entity()
export class Articles extends BaseEntity {
  @PrimaryGeneratedColumn()
  _id: number;

  @Column()
  article_id: string;

  @Column()
  owner_id: string;

  @Column()
  author: string;

  @Column()
  title: string;

  @Column()
  body: string;

  @Column()
  img_name: string;

  @Column()
  comment_count: number;

  @Column()
  scrap_count: number;

  @Column()
  complain_count: number;

  @OneToOne(() => Users, (user) => user.article)
  @JoinColumn({ name: 'owner_id' })
  owner: Users;

  @CreateDateColumn({
    type: 'timestamptz',
  })
  created_at: Date;

  @UpdateDateColumn({
    type: 'timestamptz',
  })
  updated_at: Date;
}
