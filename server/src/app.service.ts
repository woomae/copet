import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  copetInfo(): string {
    return 'copet-info';
  }
}
