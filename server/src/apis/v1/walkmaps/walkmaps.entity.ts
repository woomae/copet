import {
  Column,
  CreateDateColumn,
  Entity,
  JoinColumn,
  ManyToOne,
  OneToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { Photos } from '../photos/photos.entity';
import { Users } from '../users/users.entity';

@Entity()
export class Walkmaps {
  @PrimaryGeneratedColumn()
  _id: number;

  @Column()
  walk_started_at: string;

  @Column()
  steps: number;

  @Column()
  duration_seconds: number;

  @OneToOne(() => Photos, (photo) => photo.walkmap, {
    cascade: ['remove'],
  })
  @JoinColumn({ name: 'photo' })
  photo: Photos;

  @ManyToOne(() => Users, (user) => user._id, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'owner_id' })
  owner_id: number;

  @CreateDateColumn({
    type: 'timestamptz',
  })
  created_at: Date;
}
