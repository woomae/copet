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
import { Photos } from '../photos/photos.entity';
import { Exclude } from 'class-transformer';
import { Stars } from '../stars/stars.entity';

@Entity()
export class Articles extends BaseEntity {
  @PrimaryGeneratedColumn()
  _id: number;

  @Column()
  author: string;

  @Column()
  title: string;

  @Column({ type: 'text' })
  body: string;

  @Column()
  category: string;

  @Column({ default: 0 })
  comment_count: number;

  @Column({ default: 0 })
  scrap_count: number;

  @Column({ default: 0 })
  complain_count: number;

  @ManyToOne(() => Users, (user) => user._id, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'owner_id' })
  owner_id: number;

  @OneToMany(() => Comments, (comment) => comment.article_id, {
    cascade: ['remove'],
  })
  comments: Comments[];

  @OneToMany(() => Photos, (photo) => photo.article, {
    cascade: ['remove'],
  })
  photos: Photos[];

  @OneToMany(() => Stars, (star) => star.article_id, {
    cascade: ['remove'],
  })
  stars: Stars[];

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
