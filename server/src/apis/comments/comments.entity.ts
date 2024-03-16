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
import { Articles } from '../articles/articles.entity';

@Entity()
export class Comments extends BaseEntity {
  @PrimaryGeneratedColumn()
  _id: number;

  @Column({ generated: 'increment', unique: true })
  comment_id: number;

  @Column()
  comment_owner_id: number;

  @ManyToOne(() => Articles, (article) => article.article_id, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'connected_article_id' })
  connected_article_id: number;

  @Column()
  nickname: string;

  @Column()
  comment: string;

  @CreateDateColumn({
    type: 'timestamptz',
  })
  created_at: Date;

  @UpdateDateColumn({
    type: 'timestamptz',
  })
  updated_at: Date;
}
