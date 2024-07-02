import {
  BaseEntity,
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
  OneToMany,
  ManyToMany,
  JoinTable,
} from 'typeorm';
import { Articles } from '../articles/articles.entity';
import { Friends } from '../friends/friends.entity';
import { Stars } from '../stars/stars.entity';
import { PetKeywords } from '../petkeywords/petkeywords.entity';
import { Photos } from '../photos/photos.entity';
import { Exclude } from 'class-transformer';

@Entity()
export class Users {
  @PrimaryGeneratedColumn()
  _id: number;

  @Exclude({ toPlainOnly: true })
  @Column({ unique: true })
  provider_id: string;

  @Column({ nullable: true })
  nickname: string;

  @Exclude({ toPlainOnly: true })
  @Column({ unique: true })
  email: string;

  @Column({ nullable: true })
  pet_category: string;

  @Exclude({ toPlainOnly: true })
  @Column({ type: 'json', nullable: true })
  region: {
    state: string;
    city: string;
    district: string;
  };

  @Column({ nullable: true })
  intro: string;

  @OneToMany(() => Articles, (article) => article.owner_id, {
    cascade: ['remove'],
  })
  owner_id: Articles[];

  @OneToMany(() => Friends, (friend) => friend.friend_user_id, {
    cascade: ['remove'],
  })
  friend_user_id: Friends[];

  @OneToMany(() => Stars, (star) => star.clicked_user_id, {
    cascade: ['remove'],
  })
  clicked_user_id: Stars[];

  @ManyToMany(() => PetKeywords, (petKeyword) => petKeyword.users)
  @JoinTable()
  petkeywords: PetKeywords[];

  @OneToMany(() => Photos, (photo) => photo.user, {
    cascade: ['remove'],
  })
  photo: Photos;

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
