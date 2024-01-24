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
import { Articles } from '../articles/articles.entity';

@Entity()
export class Users extends BaseEntity {
  @PrimaryGeneratedColumn()
  _id: number;

  @Column({ nullable: true })
  name: string;

  @Column({ unique: true, nullable: true })
  nickname: string;

  @Column({ unique: true })
  email: string;

  @Column({ nullable: true })
  catagory: string;

  @Column({ nullable: true })
  region: string;

  @Column({ nullable: true })
  petimg: string;

  @Column({ nullable: true })
  petkeyword: string;

  @OneToOne(() => Articles, (article) => article.owner)
  @JoinColumn({ name: 'owner_id' })
  article: Articles;

  @CreateDateColumn({
    type: 'timestamptz',
  })
  created_at: Date;

  @UpdateDateColumn({
    type: 'timestamptz',
  })
  updated_at: Date;
}
