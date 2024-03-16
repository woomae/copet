import {
  BaseEntity,
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
  ManyToOne,
  JoinColumn,
  OneToMany,
} from 'typeorm';
import { Users } from '../users/users.entity';
import { Comments } from '../comments/comments.entity';

@Entity()
export class Articles extends BaseEntity {
  @PrimaryGeneratedColumn()
  _id: number;

  @Column({ generated: 'increment', unique: true })
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

  @ManyToOne(() => Users, (user) => user._id, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'owner_id' })
  owner_id: number;

  @OneToMany(() => Comments, (comment) => comment.connected_article_id, {
    onDelete: 'CASCADE',
  })
  connected_article_id: Comments[];

  @CreateDateColumn({
    type: 'timestamptz',
  })
  created_at: Date;

  @UpdateDateColumn({
    type: 'timestamptz',
  })
  updated_at: Date;
}
