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
    const rows = [
      {
        _id: 1,
        title: '그린광장',
        detail: '날씨도 좋은데 오천 그린광장 산책하기 좋아요!',
        region: '전라남도',
        address: '전남 순천시 오천동 702-1',
        latitude: 34.9331120366111,
        longitude: 127.49801991167,
        img_name:
          'https://mblogthumb-phinf.pstatic.net/MjAyMzA0MTNfMjk4/MDAxNjgxMzQ4OTc1NTk0.U985X7Y6tVwLQjZSlJjYKqrfzLKjs4hDK7jFwYhfRjgg.2liIPsPrkj7NOXW9-mjuD0RqEvj-yQuRpW9mvOsSax4g.JPEG.suncheonsi/9.jpg?type=w800',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 2,
        title: '그린광장',
        detail: '날씨도 좋은데 오천 그린광장 산책하기 좋아요!',
        region: '전라남도',
        address: '전남 순천시 오천동 702-1',
        latitude: 34.9331120366111,
        longitude: 127.49801991167,
        img_name:
          'https://mblogthumb-phinf.pstatic.net/MjAyMzA0MTNfMjk4/MDAxNjgxMzQ4OTc1NTk0.U985X7Y6tVwLQjZSlJjYKqrfzLKjs4hDK7jFwYhfRjgg.2liIPsPrkj7NOXW9-mjuD0RqEvj-yQuRpW9mvOsSax4g.JPEG.suncheonsi/9.jpg?type=w800',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 3,
        title: '그린광장',
        detail: '날씨도 좋은데 오천 그린광장 산책하기 좋아요!',
        region: '전라남도',
        address: '전남 순천시 오천동 702-1',
        latitude: 34.9331120366111,
        longitude: 127.49801991167,
        img_name:
          'https://mblogthumb-phinf.pstatic.net/MjAyMzA0MTNfMjk4/MDAxNjgxMzQ4OTc1NTk0.U985X7Y6tVwLQjZSlJjYKqrfzLKjs4hDK7jFwYhfRjgg.2liIPsPrkj7NOXW9-mjuD0RqEvj-yQuRpW9mvOsSax4g.JPEG.suncheonsi/9.jpg?type=w800',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 4,
        title: '그린광장',
        detail: '날씨도 좋은데 오천 그린광장 산책하기 좋아요!',
        region: '전라남도',
        address: '전남 순천시 오천동 702-1',
        latitude: 34.9331120366111,
        longitude: 127.49801991167,
        img_name:
          'https://mblogthumb-phinf.pstatic.net/MjAyMzA0MTNfMjk4/MDAxNjgxMzQ4OTc1NTk0.U985X7Y6tVwLQjZSlJjYKqrfzLKjs4hDK7jFwYhfRjgg.2liIPsPrkj7NOXW9-mjuD0RqEvj-yQuRpW9mvOsSax4g.JPEG.suncheonsi/9.jpg?type=w800',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 5,
        title: '그린광장',
        detail: '날씨도 좋은데 오천 그린광장 산책하기 좋아요!',
        region: '전라남도',
        address: '전남 순천시 오천동 702-1',
        latitude: 34.9331120366111,
        longitude: 127.49801991167,
        img_name:
          'https://mblogthumb-phinf.pstatic.net/MjAyMzA0MTNfMjk4/MDAxNjgxMzQ4OTc1NTk0.U985X7Y6tVwLQjZSlJjYKqrfzLKjs4hDK7jFwYhfRjgg.2liIPsPrkj7NOXW9-mjuD0RqEvj-yQuRpW9mvOsSax4g.JPEG.suncheonsi/9.jpg?type=w800',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 6,
        title: '그린광장',
        detail: '날씨도 좋은데 오천 그린광장 산책하기 좋아요!',
        region: '전라남도',
        address: '전남 순천시 오천동 702-1',
        latitude: 34.9331120366111,
        longitude: 127.49801991167,
        img_name:
          'https://mblogthumb-phinf.pstatic.net/MjAyMzA0MTNfMjk4/MDAxNjgxMzQ4OTc1NTk0.U985X7Y6tVwLQjZSlJjYKqrfzLKjs4hDK7jFwYhfRjgg.2liIPsPrkj7NOXW9-mjuD0RqEvj-yQuRpW9mvOsSax4g.JPEG.suncheonsi/9.jpg?type=w800',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 7,
        title: '그린광장',
        detail: '날씨도 좋은데 오천 그린광장 산책하기 좋아요!',
        region: '전라남도',
        address: '전남 순천시 오천동 702-1',
        latitude: 34.9331120366111,
        longitude: 127.49801991167,
        img_name:
          'https://mblogthumb-phinf.pstatic.net/MjAyMzA0MTNfMjk4/MDAxNjgxMzQ4OTc1NTk0.U985X7Y6tVwLQjZSlJjYKqrfzLKjs4hDK7jFwYhfRjgg.2liIPsPrkj7NOXW9-mjuD0RqEvj-yQuRpW9mvOsSax4g.JPEG.suncheonsi/9.jpg?type=w800',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 8,
        title: '그린광장',
        detail: '날씨도 좋은데 오천 그린광장 산책하기 좋아요!',
        region: '전라남도',
        address: '전남 순천시 오천동 702-1',
        latitude: 34.9331120366111,
        longitude: 127.49801991167,
        img_name:
          'https://mblogthumb-phinf.pstatic.net/MjAyMzA0MTNfMjk4/MDAxNjgxMzQ4OTc1NTk0.U985X7Y6tVwLQjZSlJjYKqrfzLKjs4hDK7jFwYhfRjgg.2liIPsPrkj7NOXW9-mjuD0RqEvj-yQuRpW9mvOsSax4g.JPEG.suncheonsi/9.jpg?type=w800',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 9,
        title: '그린광장',
        detail: '날씨도 좋은데 오천 그린광장 산책하기 좋아요!',
        region: '전라남도',
        address: '전남 순천시 오천동 702-1',
        latitude: 34.9331120366111,
        longitude: 127.49801991167,
        img_name:
          'https://mblogthumb-phinf.pstatic.net/MjAyMzA0MTNfMjk4/MDAxNjgxMzQ4OTc1NTk0.U985X7Y6tVwLQjZSlJjYKqrfzLKjs4hDK7jFwYhfRjgg.2liIPsPrkj7NOXW9-mjuD0RqEvj-yQuRpW9mvOsSax4g.JPEG.suncheonsi/9.jpg?type=w800',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 10,
        title: '그린광장',
        detail: '날씨도 좋은데 오천 그린광장 산책하기 좋아요!',
        region: '전라남도',
        address: '전남 순천시 오천동 702-1',
        latitude: 34.9331120366111,
        longitude: 127.49801991167,
        img_name:
          'https://mblogthumb-phinf.pstatic.net/MjAyMzA0MTNfMjk4/MDAxNjgxMzQ4OTc1NTk0.U985X7Y6tVwLQjZSlJjYKqrfzLKjs4hDK7jFwYhfRjgg.2liIPsPrkj7NOXW9-mjuD0RqEvj-yQuRpW9mvOsSax4g.JPEG.suncheonsi/9.jpg?type=w800',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
    ];
    return { rows, count: rows.length };
  }
  async getMerchandises(page: number, size: number): Promise<{ rows; count }> {
    const rows = [
      {
        _id: 1,
        name: '[디클펫] 펫드라이룸',
        detail: '강아지 고양이 털 건조기 애견 털말리기 드라이기',
        img_name:
          'https://shop-phinf.pstatic.net/20240126_33/1706254170116HDo1D_JPEG/107390058828606459_980346421.jpg?type=m510',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 2,
        name: '[디클펫] 펫드라이룸',
        detail: '강아지 고양이 털 건조기 애견 털말리기 드라이기',
        img_name:
          'https://shop-phinf.pstatic.net/20240126_33/1706254170116HDo1D_JPEG/107390058828606459_980346421.jpg?type=m510',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 3,
        name: '[디클펫] 펫드라이룸',
        detail: '강아지 고양이 털 건조기 애견 털말리기 드라이기',
        img_name:
          'https://shop-phinf.pstatic.net/20240126_33/1706254170116HDo1D_JPEG/107390058828606459_980346421.jpg?type=m510',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 4,
        name: '[디클펫] 펫드라이룸',
        detail: '강아지 고양이 털 건조기 애견 털말리기 드라이기',
        img_name:
          'https://shop-phinf.pstatic.net/20240126_33/1706254170116HDo1D_JPEG/107390058828606459_980346421.jpg?type=m510',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 5,
        name: '[디클펫] 펫드라이룸',
        detail: '강아지 고양이 털 건조기 애견 털말리기 드라이기',
        img_name:
          'https://shop-phinf.pstatic.net/20240126_33/1706254170116HDo1D_JPEG/107390058828606459_980346421.jpg?type=m510',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 6,
        name: '[디클펫] 펫드라이룸',
        detail: '강아지 고양이 털 건조기 애견 털말리기 드라이기',
        img_name:
          'https://shop-phinf.pstatic.net/20240126_33/1706254170116HDo1D_JPEG/107390058828606459_980346421.jpg?type=m510',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 7,
        name: '[디클펫] 펫드라이룸',
        detail: '강아지 고양이 털 건조기 애견 털말리기 드라이기',
        img_name:
          'https://shop-phinf.pstatic.net/20240126_33/1706254170116HDo1D_JPEG/107390058828606459_980346421.jpg?type=m510',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 8,
        name: '[디클펫] 펫드라이룸',
        detail: '강아지 고양이 털 건조기 애견 털말리기 드라이기',
        img_name:
          'https://shop-phinf.pstatic.net/20240126_33/1706254170116HDo1D_JPEG/107390058828606459_980346421.jpg?type=m510',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 9,
        name: '[디클펫] 펫드라이룸',
        detail: '강아지 고양이 털 건조기 애견 털말리기 드라이기',
        img_name:
          'https://shop-phinf.pstatic.net/20240126_33/1706254170116HDo1D_JPEG/107390058828606459_980346421.jpg?type=m510',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 10,
        name: '[디클펫] 펫드라이룸',
        detail: '강아지 고양이 털 건조기 애견 털말리기 드라이기',
        img_name:
          'https://shop-phinf.pstatic.net/20240126_33/1706254170116HDo1D_JPEG/107390058828606459_980346421.jpg?type=m510',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
    ];
    return { rows, count: rows.length };
  }
}
