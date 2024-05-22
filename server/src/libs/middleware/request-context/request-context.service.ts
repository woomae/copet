import { Injectable } from '@nestjs/common';

@Injectable()
export class RequestContextService {
  private static context: Record<string, any> = {};

  static set(key: string, value: any) {
    RequestContextService.context[key] = value;
  }

  static get(key: string): any {
    return RequestContextService.context[key];
  }

  static clear() {
    RequestContextService.context = {};
  }
}
