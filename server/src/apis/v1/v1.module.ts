import { Module } from '@nestjs/common';
import { ArticlesModule } from './articles/articles.module';
import { AuthModule } from './auth/auth.module';
import { CommentsModule } from './comments/comments.module';
import { FriendsModule } from './friends/friends.module';
import { MocksModule } from './mocks/mocks.module';
import { RanksModule } from './ranks/ranks.module';
import { StarsModule } from './stars/stars.module';
import { UsersModule } from './users/users.module';

@Module({
  imports: [
    AuthModule,
    ArticlesModule,
    UsersModule,
    FriendsModule,
    StarsModule,
    CommentsModule,
    MocksModule,
    RanksModule,
  ],
})
export class V1Module {}
