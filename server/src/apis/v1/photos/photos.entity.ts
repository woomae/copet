import {
  Column,
  CreateDateColumn,
  Entity,
  JoinColumn,
  ManyToOne,
  OneToOne,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { Users } from '../users/users.entity';
import { Articles } from '../articles/articles.entity';
import { Exclude } from 'class-transformer';
import { Walkmaps } from '../walkmaps/walkmaps.entity';

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

  @OneToOne(() => Walkmaps, (walkmap) => walkmap.photo, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'walkmap' })
  walkmap: Walkmaps;

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
