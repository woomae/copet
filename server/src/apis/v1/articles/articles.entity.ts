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
    onDelete: 'CASCADE',
  })
  article_id: Comments[];

  @OneToMany(() => Photos, (photo) => photo.article, {
    onDelete: 'CASCADE',
  })
  photos: Photos[];

  @CreateDateColumn({
    type: 'timestamptz',
  })
  created_at: Date;

  @UpdateDateColumn({
    type: 'timestamptz',
  })
  updated_at: Date;
}
