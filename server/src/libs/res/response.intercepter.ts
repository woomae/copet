import {
  CallHandler,
  ExecutionContext,
  HttpStatus,
  Injectable,
  NestInterceptor,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { Result } from './result';
import { winstonLogger } from '../logger/winston.util';

@Injectable()
export class ResponseInterceptor<T> implements NestInterceptor<T, any> {
  intercept(
    context: ExecutionContext,
    next: CallHandler<T>,
  ): Observable<any> | Promise<Observable<any>> {
    const ctx = context.switchToHttp();
    const res = ctx.getResponse();
    const req = context.switchToHttp().getRequest();
    const { ip, method, originalUrl } = req;
    const userAgent = req.get('user-agent');

    return next.handle().pipe(
      map((data) => {
        winstonLogger.log(
          `[${method}]${originalUrl} ${200} ${ip} ${userAgent}`,
        );
        const result = Result.ok(data).toJson();
        res.status(HttpStatus.OK).json(result);
      }),
    );
  }
}
