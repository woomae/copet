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
import { Exclude } from 'class-transformer';

@Entity()
export class Comments extends BaseEntity {
  @PrimaryGeneratedColumn()
  _id: number;

  @Column()
  owner_id: number;

  @ManyToOne(() => Articles, (article) => article._id, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'article_id' })
  article_id: number;

  @Column()
  nickname: string;

  @Column({ type: 'text' })
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
