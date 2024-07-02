import {
  BaseEntity,
  Column,
  CreateDateColumn,
  Entity,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { Users } from '../users/users.entity';
import { Articles } from '../articles/articles.entity';
import { Exclude } from 'class-transformer';

@Entity()
export class Photos {
  @Exclude({ toPlainOnly: true })
  @PrimaryGeneratedColumn()
  _id: number;

  @Column()
  img_path: string;

  @ManyToOne(() => Users, (user) => user.photo, {
    onDelete: 'CASCADE',
  })
  user: Users;

  @ManyToOne(() => Articles, (article) => article.photos, {
    onDelete: 'CASCADE',
  })
  article: Articles;

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
