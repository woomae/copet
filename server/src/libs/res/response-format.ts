import { StandardResponseDto } from 'src/dto/standard-response.dto';
import ApiCodes from './api.codes';
import ApiMessages from './api.messages';

export default class ResponseFormat {
  public isSuccess: boolean;
  public error: any;
  private readonly _value: any;

  private constructor(isSuccess: boolean, error: any, value: any) {
    if (isSuccess && error) {
      throw new Error(
        `InvalidOperation: A result cannot be successful and contain an error`,
      );
    }
    if (!isSuccess && !error) {
      throw new Error(
        `InvalidOperation: A failing result needs to contain an error message`,
      );
    }

    this.isSuccess = isSuccess;
    this.error = error;
    this._value = value;

    Object.freeze(this);
  }

  public getValue(): any {
    return this._value;
  }

  public static ok(value?: any): ResponseFormat {
    return new ResponseFormat(true, null, value);
  }

  public static fail(error: any): ResponseFormat {
    return new ResponseFormat(false, error, null);
  }

  public format(): any {
    const error = this.error;
    if (error && !this.isSuccess) {
      const detail = error?.detail;
      this.error.detail = {
        ...detail,
        ...{
          location:
            error?.__file__ &&
            `${error?.__file__}:${error?.__line__} (${error?.__function__})`,
          trace: error?.stack.split('\n')[0],
          version: error?.version,
          build: error?.build,
          hostname: error?.hostname,
          tid: error?.tid,
        },
      };
    }
    if (this.isSuccess) {
      return new StandardResponseDto(ApiCodes.OK, ApiMessages.OK, this._value);
    } else if (this.error.response) {
      return new StandardResponseDto(
        this.error.response.statusCode,
        this.error.response.message,
        null,
      );
    } else {
      return new StandardResponseDto(
        ApiCodes.INTERNAL_SERVER_ERROR,
        ApiMessages.INTERNAL_SERVER_ERROR,
        error?.detail,
      );
    }
  }
}
