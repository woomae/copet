import {
  BaseEntity,
  Column,
  CreateDateColumn,
  Entity,
  ManyToMany,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { Users } from '../users/users.entity';

@Entity()
export class PetKeywords extends BaseEntity {
  @PrimaryGeneratedColumn()
  _id: number;

  @Column({ unique: true })
  keyword: string;

  @CreateDateColumn({
    type: 'timestamptz',
  })
  created_at: Date;

  @UpdateDateColumn({
    type: 'timestamptz',
  })
  updated_at: Date;

  @ManyToMany(() => Users, (user) => user.petkeywords)
  users: Users[];
}
