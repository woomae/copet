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
  OneToOne,
} from 'typeorm';
import { Articles } from '../articles/articles.entity';
import { Friends } from '../friends/friends.entity';
import { Stars } from '../stars/stars.entity';
import { PetKeywords } from '../petkeywords/petkeywords.entity';
import { Photos } from '../photos/photos.entity';
import { Exclude } from 'class-transformer';
import { Notifications } from '../notifications/notification.entity';
import { Walkmaps } from '../walkmaps/walkmaps.entity';

@Entity()
export class Users {
  @PrimaryGeneratedColumn()
  _id: number;

  @Exclude({ toPlainOnly: true })
  @Column({ unique: true })
  provider_id: string;

  @Exclude({ toPlainOnly: true })
  @Column({ nullable: true })
  firebase_token: string;

  @Column({ nullable: true })
  nickname: string;

  @Exclude({ toPlainOnly: true })
  @Column({ unique: true })
  email: string;

  @Column({ nullable: true })
  pet_category: string;

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

  @OneToMany(() => Notifications, (notification) => notification.user_id, {
    cascade: ['remove'],
  })
  notification: Notifications[];

  @OneToMany(() => Walkmaps, (walkmap) => walkmap.owner_id, {
    cascade: ['remove'],
  })
  walkmap: Walkmaps[];

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
