import { Injectable } from '@nestjs/common';

@Injectable()
export class MocksService {
  async getPetPlaces(
    page: number,
    size: number,
    region: string,
  ): Promise<{ rows; count }> {
    //지역 파라미터 체크, but 목업데이터라서 주석처리
    // if (region) {
    //   //지역별로 데이터를 가져옴
    //   const rows = [{}, {}];
    //   return { rows, count: rows.length };
    // }
    const rows = [{}, {}];
    return { rows, count: rows.length };
  }

  async getMerchandises(page: number, size: number): Promise<{ rows; count }> {
    const rows = [{}, {}];
    return { rows, count: rows.length };
  }
}
