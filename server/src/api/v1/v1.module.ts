import { Module } from '@nestjs/common';
import { V1Service } from './v1.service';

@Module({
  providers: [V1Service],
})
export class V1Module {}
