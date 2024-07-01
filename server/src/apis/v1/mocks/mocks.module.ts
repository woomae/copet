import { Module } from '@nestjs/common';
import { MocksController } from './mocks.controller';
import { MocksService } from './mocks.service';

@Module({
  controllers: [MocksController],
  providers: [MocksService]
})
export class MocksModule {}
