//deprecated
import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
  HttpStatus,
} from '@nestjs/common';
import { Observable, throwError } from 'rxjs';
import { tap, catchError } from 'rxjs/operators';
import { winstonLogger } from './winston.util';

@Injectable()
export class LoggingInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    const req = context.switchToHttp().getRequest();
    const { ip, method, originalUrl } = req;
    const userAgent = req.get('user-agent');

    return next.handle().pipe(
      tap(
        (response) => {
          const { statusCode } = response;
          winstonLogger.log(
            `[${method}]${originalUrl}(${statusCode}) ${ip} ${userAgent}`,
          );
        },
        catchError((error) => {
          console.log('error', error);
          const statusCode = error.status || HttpStatus.INTERNAL_SERVER_ERROR;
          if (statusCode >= 400 && statusCode < 500) {
            winstonLogger.warn(
              `[${method}]${originalUrl}(${statusCode}) ${ip} ${userAgent}`,
            );
            return throwError(() => error);
          } else if (statusCode >= 500) {
            winstonLogger.error(
              `[${method}]${originalUrl}(${statusCode}) ${ip} ${userAgent}`,
            );
            return throwError(() => error);
          }
        }),
      ),
    );
  }
}
