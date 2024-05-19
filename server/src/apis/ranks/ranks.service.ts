import { InjectRedis } from '@nestjs-modules/ioredis';
import { Injectable } from '@nestjs/common';
import Redis from 'ioredis';

@Injectable()
export class RanksService {
  constructor(@InjectRedis() private readonly redis: Redis) {}

  // 유저별 최근 검색어 추가 및 인기 검색어 업데이트
  async addSearchTerm(userId: number, term: string) {
    const userKey = `SearchLog:${userId}`;
    const popularKey = 'popular_searches';
    const timestampKey = `${popularKey}:timestamps`;
    const now = Date.now();

    // 유저별 최근 검색어 업데이트
    await this.redis.lpush(userKey, term);
    await this.redis.ltrim(userKey, 0, 9);

    // 검색어가 이미 있는지 확인
    const score = await this.redis.zscore(popularKey, term);
    if (score !== null) {
      // 검색어가 이미 있는 경우 스코어를 증가시킴
      await this.redis.zincrby(popularKey, 1, term);
    } else {
      // 검색어가 없는 경우 새로운 멤버로 추가하고 스코어를 1로 설정
      await this.redis.zadd(popularKey, 1, term);
    }

    // 검색어의 타임스탬프 업데이트
    await this.redis.hset(timestampKey, term, now);

    // 일정 기간이 지난 검색어 점수를 낮추기
    await this.decreaseOldSearchTerms();
  }

  // 유저별 최근 검색어 가져오기
  async getRecentSearchTerms(userId: number): Promise<string[]> {
    const userKey = `SearchLog:${userId}`;
    const terms = await this.redis.lrange(userKey, 0, 9);
    return terms;
  }
  async deleteRecentSearchTerms(userId: number, term: string): Promise<void> {
    const userKey = `SearchLog:${userId}`;
    // 리스트에서 특정 검색어 삭제
    await this.redis.lrem(userKey, 1, term);
  }

  // 인기 검색어 가져오기
  async getTopSearchTerms(): Promise<string[]> {
    const popularKey = 'popular_searches';
    const terms = await this.redis.zrevrange(popularKey, 0, 9);
    return terms;
  }

  // 일정 시간이 지난 검색어 점수를 낮추기
  async decreaseOldSearchTerms() {
    const popularKey = 'popular_searches';
    const timestampKey = `${popularKey}:timestamps`;
    const now = Date.now();
    const sixHours = 6 * 60 * 60 * 1000;

    // 인기 검색어와 점수 목록을 가져옴
    const termsWithScores = await this.redis.zrange(
      popularKey,
      0,
      -1,
      'WITHSCORES',
    );
    for (let i = 0; i < termsWithScores.length; i += 2) {
      const term = termsWithScores[i];
      const score = parseFloat(termsWithScores[i + 1]);
      const timestamp = await this.redis.hget(timestampKey, term);

      if (timestamp) {
        const age = now - parseFloat(timestamp);
        if (age > sixHours) {
          // 일정 시간(6시간)이 지난 검색어의 점수를 낮춤
          const newScore = score * Math.exp(-age / sixHours);
          await this.redis.zadd(popularKey, newScore, term);
        }
      }
    }
  }
}
