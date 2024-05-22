import { WinstonModule, utilities } from 'nest-winston';
import * as winston from 'winston';
import * as winstonDaily from 'winston-daily-rotate-file';

const dailyOption = (level: string) => {
  return {
    level,
    datePattern: 'YYYY-MM-DD',
    dirname: `./logs/${level}`,
    filename: `%DATE%.${level}.log`,
    maxFiles: 30,
    zippedArchive: true,
    format: winston.format.combine(
      winston.format.timestamp(),
      winston.format.ms(),
      utilities.format.nestLike('Copet', {
        colors: false,
        prettyPrint: true,
      }),
    ),
  };
};

export const winstonLogger = WinstonModule.createLogger({
  transports: [
    new winston.transports.Console({
      level: process.env.NODE_ENV === 'prod' ? 'http' : 'silly',
      format: winston.format.combine(
        winston.format.timestamp(),
        winston.format.ms(),
        utilities.format.nestLike('Copet', {
          colors: true,
          prettyPrint: true,
        }),
      ),
    }),
    new winstonDaily(dailyOption('info')),
    new winstonDaily(dailyOption('warn')),
    new winstonDaily(dailyOption('error')),
  ],
});
