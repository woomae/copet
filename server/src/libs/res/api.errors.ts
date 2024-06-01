import * as os from 'os';
import { RequestContextService } from '../middleware/request-context/request-context.service';
import { prune } from '../utils';

export default class ApiError extends Error {
  public detail;
  public hostname;
  public __line__;
  public __function__;
  public __file__;

  public constructor(
    public code: number,
    msg?: string,
    detail?: any,
  ) {
    const message = msg;
    super(message);

    const errResponse = RequestContextService.get('DEBUG_RESPONSE_ERROR_LEVEL');
    const isProd = process.env.NODE_ENV === 'prod';
    const isVerbose = errResponse ? errResponse?.includes('verbose') : !isProd;

    this.code = code;
    this.detail = isVerbose
      ? {
          ...detail,
          ...{
            path: detail?.req?.path,
            method: detail?.req?.method,
            param: detail?.req?.param,
            query: detail?.req?.query,
            body: detail?.req?.body,
          },
        }
      : detail;

    const e = detail?.error || new Error();
    const frame = e.stack.split('\n')[2];
    this.hostname = os.hostname();
    this.detail = prune(this.detail);
    this.__line__ = frame.split(':').reverse()[1];
    this.__file__ = frame.split(':')[0].split('/').reverse()[0];
    this.__function__ = frame.split(' ')[5];
  }
}
