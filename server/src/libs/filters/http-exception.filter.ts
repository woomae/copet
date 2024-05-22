import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,
} from '@nestjs/common';
import { Response } from 'express';
import { Result } from '../res/result';
import { HttpStatus } from '@nestjs/common';
import { winstonLogger } from '../logger/winston.util';

// 사용자 정의 인터페이스를 통해 IP 속성을 정의
interface CustomRequest extends Request {
  ip: string;
}

@Catch()
export class AllExceptionsFilter implements ExceptionFilter {
  catch(exception: unknown, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const res = ctx.getResponse<Response>();
    const request = ctx.getRequest<CustomRequest>();
    const status =
      exception instanceof HttpException
        ? exception.getStatus()
        : HttpStatus.INTERNAL_SERVER_ERROR;

    const message =
      exception instanceof HttpException ? exception.getResponse() : exception;

    winstonLogger.error(
      `[${request.method}]${request.url} ${status} ${request.ip} ${
        request.headers['user-agent']
      } detail: ${JSON.stringify(message)}`,
    );

    const response = Result.fail<Error>(exception).toJson();
    res.status(HttpStatus.OK).json(response);
  }
}
