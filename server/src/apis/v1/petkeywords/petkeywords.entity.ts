import {
  BaseEntity,
  Column,
  CreateDateColumn,
  Entity,
  ManyToMany,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { Users } from '../users/users.entity';
import { Exclude } from 'class-transformer';

@Entity()
export class PetKeywords {
  @Exclude({ toPlainOnly: true })
  @PrimaryGeneratedColumn()
  _id: number;

  @Column({ unique: true })
  keyword: string;

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

  @Exclude({ toPlainOnly: true })
  @ManyToMany(() => Users, (user) => user.petkeywords)
  users: Users[];
}
