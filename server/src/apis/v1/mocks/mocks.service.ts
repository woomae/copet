import { Injectable } from '@nestjs/common';

@Injectable()
export class MocksService {
  async getPetPlaces(
    page: number,
    size: number,
    region: string,
  ): Promise<{ rows; count }> {
    const rows = [
      {
        _id: 1,
        title: '와온소공원',
        detail: '와온소공원',
        region: '전라남도',
        address: '전남 순천시 해룡면 상내리 820',
        latitude: 34.8500233574393,
        longitude: 127.523900933156,
        img_name:
          'https://copet-life.s3.ap-northeast-2.amazonaws.com/mocks/petPlaces/%EC%99%80%EC%98%A8%EC%86%8C%EA%B3%B5%EC%9B%90.jpg',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 2,
        title: '신안튤립공원',
        detail: '신안튤립공원',
        region: '전라남도',
        address: '전남 신안군 임자면 대기리 산327-2',
        latitude: 35.1035198322261,
        longitude: 126.075158302897,
        img_name:
          'https://copet-life.s3.ap-northeast-2.amazonaws.com/mocks/petPlaces/%EC%8B%A0%EC%95%88%ED%8A%A4%EB%A6%BD%EA%B3%B5%EC%9B%90.jpg',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 3,
        title: '빛가람호수공원',
        detail: '빛가람호수공원',
        region: '전라남도',
        address: '전남 나주시 호수로 77',
        latitude: 35.0168333662014,
        longitude: 126.79043610965,
        img_name:
          'https://copet-life.s3.ap-northeast-2.amazonaws.com/mocks/petPlaces/%EB%B9%9B%EA%B0%80%EB%9E%8C+%ED%98%B8%EC%88%98%EA%B3%B5%EC%9B%90.jpg',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 4,
        title: '섬진강 대나무숲길',
        detail: '섬진강 대나무숲길',
        region: '전라남도',
        address: '전남 구례군 구례읍 원방리 1',
        latitude: 35.186307666529,
        longitude: 127.465293178944,
        img_name:
          'https://copet-life.s3.ap-northeast-2.amazonaws.com/mocks/petPlaces/%EC%84%AC%EC%A7%84%EA%B0%95+%EB%8C%80%EB%82%98%EB%AC%B4+%EC%88%B2%EA%B8%B8.jpg',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 5,
        title: '황룡강생태공원',
        detail: '황룡강생태공원',
        region: '전라남도',
        address: '전남 장성군 장성읍 기산리 57-14',
        latitude: 34.9331120366111,
        longitude: 127.49801991167,
        img_name:
          'https://copet-life.s3.ap-northeast-2.amazonaws.com/mocks/petPlaces/%ED%99%A9%EB%A3%A1%EA%B0%95+%EC%83%9D%ED%83%9C%EA%B3%B5%EC%9B%90.jpg',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 6,
        title: '동구리호수공원',
        detail: '동구리호수공원',
        region: '전라남도',
        address: '전남 화순군 화순읍 동구리 123',
        latitude: 35.3056113802907,
        longitude: 126.777543939218,
        img_name:
          'https://copet-life.s3.ap-northeast-2.amazonaws.com/mocks/petPlaces/%EB%8F%99%EA%B5%AC%EB%A6%AC+%ED%98%B8%EC%88%98%EA%B3%B5%EC%9B%90.jpg',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 7,
        title: '수변공원',
        detail: '수변공원',
        region: '전라남도',
        address: '전남 무안군 삼향읍 남악리 2621',
        latitude: 34.8012621260453,
        longitude: 126.460434376327,
        img_name:
          'https://copet-life.s3.ap-northeast-2.amazonaws.com/mocks/petPlaces/%EC%88%98%EB%B3%80%EA%B3%B5%EC%9B%90.jpg',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 8,
        title: '지리산치즈랜드',
        detail: '지리산치즈랜드',
        region: '전라남도',
        address: '전남 구례군 산동면 산업로 1590-62',
        latitude: 35.2778955730424,
        longitude: 127.421732818587,
        img_name:
          'https://copet-life.s3.ap-northeast-2.amazonaws.com/mocks/petPlaces/%EC%A7%80%EB%A6%AC%EC%82%B0%EC%B9%98%EC%A6%88%EB%9E%9C%EB%93%9C.jpg',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 9,
        title: '세랑제',
        detail: '세랑제',
        region: '전라남도',
        address: '전남 화순군 화순읍 세량리 98',
        latitude: 35.078539371123,
        longitude: 126.920264026173,
        img_name:
          'https://copet-life.s3.ap-northeast-2.amazonaws.com/mocks/petPlaces/%EC%84%B8%EB%9F%89%EC%A0%9C.jpg',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 10,
        title: '왕인박사유적지',
        detail: '왕인박사유적지',
        region: '전라남도',
        address: '전남 영암군 군서면 왕인로 440',
        latitude: 34.7565303792414,
        longitude: 126.629121078815,
        img_name:
          'https://copet-life.s3.ap-northeast-2.amazonaws.com/mocks/petPlaces/%EC%99%95%EC%9D%B8%EB%B0%95%EC%82%AC+%EC%9C%A0%EC%A0%81%EC%A7%80.jpg',
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
        name: '망고브러쉬 스팀 빗',
        detail: '펫케어 망고브러쉬 고양이 강아지 스팀 빗',
        img_name:
          'https://copet-life.s3.ap-northeast-2.amazonaws.com/mocks/merchandises/%ED%8E%AB%EC%BC%80%EC%96%B4+%EB%A7%9D%EA%B3%A0%EB%B8%8C%EB%9F%AC%EC%89%AC+%EA%B3%A0%EC%96%91%EC%9D%B4+%EA%B0%95%EC%95%84%EC%A7%80+%EC%8A%A4%ED%8C%80+%EB%B9%97.jpg',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 2,
        name: '애완견 견사',
        detail: '강아지 울타리 팬스 철장 애견 새끼 애완견 견사 DIY',
        img_name:
          'https://copet-life.s3.ap-northeast-2.amazonaws.com/mocks/merchandises/%EA%B0%95%EC%95%84%EC%A7%80+%EC%9A%B8%ED%83%80%EB%A6%AC+%ED%8C%AC%EC%8A%A4+%EC%B2%A0%EC%9E%A5+%EC%95%A0%EA%B2%AC+%EC%83%88%EB%81%BC+%EC%95%A0%EC%99%84%EA%B2%AC+%EA%B2%AC%EC%82%AC+DIY.jpg',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 3,
        name: '강아지 카시트',
        detail: '울리 강아지 카시트 애견 클린 커버 카시트 M',
        img_name:
          'https://copet-life.s3.ap-northeast-2.amazonaws.com/mocks/merchandises/%EC%9A%B8%EB%A6%AC+%EA%B0%95%EC%95%84%EC%A7%80+%EC%B9%B4%EC%8B%9C%ED%8A%B8+%EC%95%A0%EA%B2%AC+%ED%81%B4%EB%A6%B0+%EC%BB%A4%EB%B2%84+%EC%B9%B4%EC%8B%9C%ED%8A%B8+M.jpg',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 4,
        name: '강아지 노즈워크 장난감',
        detail:
          '강아지 노즈워크 장난감 분리불안 훈련 담요 스너플매트 C타입 중대형',
        img_name:
          'https://copet-life.s3.ap-northeast-2.amazonaws.com/mocks/merchandises/%EA%B0%95%EC%95%84%EC%A7%80+%EB%85%B8%EC%A6%88%EC%9B%8C%ED%81%AC+%EC%9E%A5%EB%82%9C%EA%B0%90+%EB%B6%84%EB%A6%AC%EB%B6%88%EC%95%88+%ED%9B%88%EB%A0%A8+%EB%8B%B4%EC%9A%94+%EC%8A%A4%EB%84%88%ED%94%8C%EB%A7%A4%ED%8A%B8+C%ED%83%80%EC%9E%85+%EC%A4%91%EB%8C%80%ED%98%95.jpg',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 5,
        name: '강아지매트',
        detail: '퍼핑 강아지매트 미끄럼방지 복도 매트리스 바닥 시공',
        img_name:
          'https://copet-life.s3.ap-northeast-2.amazonaws.com/mocks/merchandises/%ED%8D%BC%ED%95%91+%EA%B0%95%EC%95%84%EC%A7%80%EB%A7%A4%ED%8A%B8+%EB%AF%B8%EB%81%84%EB%9F%BC%EB%B0%A9%EC%A7%80+%EB%B3%B5%EB%8F%84+%EB%A7%A4%ED%8A%B8%EB%A6%AC%EC%8A%A4+%EB%B0%94%EB%8B%A5+%EC%8B%9C%EA%B3%B5.jpg',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 6,
        name: '배변패드 반려견',
        detail:
          '큰패드 절약형 대형 50g x 160매 박스 정직한 애견 강아지 배변패드 반려견',
        img_name:
          'https://copet-life.s3.ap-northeast-2.amazonaws.com/mocks/merchandises/%ED%81%B0%ED%8C%A8%EB%93%9C+%EC%A0%88%EC%95%BD%ED%98%95+%EB%8C%80%ED%98%95+50g+x+160%EB%A7%A4+%EB%B0%95%EC%8A%A4+%EC%A0%95%EC%A7%81%ED%95%9C+%EC%95%A0%EA%B2%AC+%EA%B0%95%EC%95%84%EC%A7%80+%EB%B0%B0%EB%B3%80%ED%8C%A8%EB%93%9C+%EB%B0%98%EB%A0%A4%EA%B2%AC.jpg',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 7,
        name: '애견아이스팩 돌침대',
        detail: '강아지쿨매트 애견 고양이 아이스팩 돌침대',
        img_name:
          'https://copet-life.s3.ap-northeast-2.amazonaws.com/mocks/merchandises/%EA%B0%95%EC%95%84%EC%A7%80%EC%BF%A8%EB%A7%A4%ED%8A%B8+%EC%95%A0%EA%B2%AC+%EA%B3%A0%EC%96%91%EC%9D%B4+%EC%95%84%EC%9D%B4%EC%8A%A4%ED%8C%A9+%EB%8F%8C%EC%B9%A8%EB%8C%80.jpg',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 8,
        name: '름 쿨링 강아지 방석',
        detail: '울리 달콤수박 여름 쿨링 강아지 방석 L',
        img_name:
          'https://copet-life.s3.ap-northeast-2.amazonaws.com/mocks/merchandises/%EC%9A%B8%EB%A6%AC+%EB%8B%AC%EC%BD%A4%EC%88%98%EB%B0%95+%EC%97%AC%EB%A6%84+%EC%BF%A8%EB%A7%81+%EA%B0%95%EC%95%84%EC%A7%80+%EB%B0%A9%EC%84%9D+L.jpg',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 9,
        name: '강아지샴푸 500ml',
        detail:
          '마이플러피 강아지샴푸 고양이 애견 목욕 천연 저자극 플러피케어 마일드샴푸 500ml',
        img_name:
          'https://copet-life.s3.ap-northeast-2.amazonaws.com/mocks/merchandises/%EB%A7%88%EC%9D%B4%ED%94%8C%EB%9F%AC%ED%94%BC+%EA%B0%95%EC%95%84%EC%A7%80%EC%83%B4%ED%91%B8+%EA%B3%A0%EC%96%91%EC%9D%B4+%EC%95%A0%EA%B2%AC+%EB%AA%A9%EC%9A%95+%EC%B2%9C%EC%97%B0+%EC%A0%80%EC%9E%90%EA%B7%B9+%ED%94%8C%EB%9F%AC%ED%94%BC%EC%BC%80%EC%96%B4+%EB%A7%88%EC%9D%BC%EB%93%9C%EC%83%B4%ED%91%B8+500ml.jpg',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
      {
        _id: 10,
        name: '강아지계단 펫 스텝 4단',
        detail: '논슬립 강아지계단 어셈블 펫 스텝 4단',
        img_name:
          'https://copet-life.s3.ap-northeast-2.amazonaws.com/mocks/merchandises/%EB%85%BC%EC%8A%AC%EB%A6%BD+%EA%B0%95%EC%95%84%EC%A7%80%EA%B3%84%EB%8B%A8+%EC%96%B4%EC%85%88%EB%B8%94+%ED%8E%AB+%EC%8A%A4%ED%85%9D+4%EB%8B%A8.jpg',
        created_at: '2024-05-13T00:00:00.000Z',
        updated_at: '2024-05-13T00:00:00.000Z',
      },
    ];
    return { rows, count: rows.length };
  }
}
