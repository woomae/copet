import {
  BaseEntity,
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
  OneToMany,
} from 'typeorm';
import { Articles } from '../articles/articles.entity';
import { Friends } from '../friends/friends.entity';
import { Stars } from '../stars/stars.entity';

@Entity()
export class Users extends BaseEntity {
  @PrimaryGeneratedColumn()
  _id: number;

  @Column({ nullable: true })
  nickname: string;

  @Column({ unique: true })
  email: string;

  @Column({ nullable: true })
  pet_catagory: string;

  @Column({ nullable: true })
  region: string;

  @Column({ nullable: true })
  petimg: string;

  @Column({ nullable: true })
  petkeyword: string;

  @Column({ nullable: true })
  intro: string;

  @OneToMany(() => Articles, (article) => article.owner_id, {
    onDelete: 'CASCADE',
  })
  owner_id: Articles[];

  @OneToMany(() => Friends, (friend) => friend.friend_user_id, {
    onDelete: 'CASCADE',
  })
  friend_user_id: Friends[];

  @OneToMany(() => Stars, (star) => star.clicked_user_id, {
    onDelete: 'CASCADE',
  })
  clicked_user_id: Stars[];

  @CreateDateColumn({
    type: 'timestamptz',
  })
  created_at: Date;

  @UpdateDateColumn({
    type: 'timestamptz',
  })
  updated_at: Date;
}
