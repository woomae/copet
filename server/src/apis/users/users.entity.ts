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

  @Column({ nullable: true })
  intro: string;

  @OneToMany(() => Articles, (article) => article.owner_id)
  owner_id: Articles[];

  @OneToMany(() => Friends, (friend) => friend.friend_user_id)
  friend_user_id: Friends[];

  @CreateDateColumn({
    type: 'timestamptz',
  })
  created_at: Date;

  @UpdateDateColumn({
    type: 'timestamptz',
  })
  updated_at: Date;
}
