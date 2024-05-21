import { winstonLogger } from './winston.util';
import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { tap } from 'rxjs/operators';

@Injectable()
export class LoggingInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    const req = context.switchToHttp().getRequest();
    const { ip, method, originalUrl } = req;
    const userAgent = req.get('user-agent');

    return next.handle().pipe(
      tap((response) => {
        const { statusCode } = response;
        const trace = response.data?.trace;
        if (statusCode >= 400 && statusCode < 500) {
          winstonLogger.warn(
            `[${method}]${originalUrl}(${statusCode}) ${ip} ${userAgent} ${statusCode} ${trace}`,
          );
        } else if (statusCode >= 500) {
          winstonLogger.error(
            `[${method}]${originalUrl}(${statusCode}) ${ip} ${userAgent} ${statusCode} ${trace}`,
          );
        }
      }),
    );
  }
}
