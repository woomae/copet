// 전라남도의 각 시/군의 구/읍/면 정보
import '../../models/region_model.dart';

 District mokpoDistricts = District(districtName: ['목포시']);
 District yeosuDistricts = District(districtName: ['여수시']);
 District suncheonDistricts = District(districtName: ['순천시']);
 District nakanDistricts = District(districtName: ['낙안면']);
 District damyangDistricts = District(districtName: ['담양읍']);
 District gochangDistricts = District(districtName: ['고창읍']);
 District guryeDistricts = District(districtName: ['구례읍']);
 District goheungDistricts = District(districtName: ['고흥읍']);
 District boseongDistricts = District(districtName: ['보성읍']);
 District hwasunDistricts = District(districtName: ['화순읍']);
 District jangheungDistricts = District(districtName: ['장흥읍']);
 District gangjinDistricts = District(districtName: ['강진읍']);
 District haenamDistricts = District(districtName: ['해남읍']);
 District yeongamDistricts = District(districtName: ['영암읍']);
 District muanDistricts = District(districtName: ['무안읍']);
 District hamyangDistricts = District(districtName: ['함양읍']);
 District hampyeongDistricts = District(districtName: ['함평읍']);
 District yeonggwangDistricts = District(districtName: ['영광읍']);
 District jangseongDistricts = District(districtName: ['장성읍']);
 District wandoDistricts = District(districtName: ['완도읍']);
 District jinsanDistricts = District(districtName: ['진산읍']);
 District sinanDistricts = District(districtName: ['신안읍']);

// 전라남도의 각 시/군 정보
 City mokpo = City(cityName: '목포시', districts: [mokpoDistricts]);
 City yeosu = City(cityName: '여수시', districts: [yeosuDistricts]);
 City suncheon = City(cityName: '순천시', districts: [suncheonDistricts]);
 City nakan = City(cityName: '낙안면', districts: [nakanDistricts]);
 City damyang = City(cityName: '담양읍', districts: [damyangDistricts]);
 City gochang = City(cityName: '고창읍', districts: [gochangDistricts]);
 City gurye = City(cityName: '구례읍', districts: [guryeDistricts]);
 City goheung = City(cityName: '고흥읍', districts: [goheungDistricts]);
 City boseong = City(cityName: '보성읍', districts: [boseongDistricts]);
 City hwasun = City(cityName: '화순읍', districts: [hwasunDistricts]);
 City jangheung = City(cityName: '장흥읍', districts: [jangheungDistricts]);
 City gangjin = City(cityName: '강진읍', districts: [gangjinDistricts]);
 City haenam = City(cityName: '해남읍', districts: [haenamDistricts]);
 City yeongam = City(cityName: '영암읍', districts: [yeongamDistricts]);
 City muan = City(cityName: '무안읍', districts: [muanDistricts]);
 City hamyang = City(cityName: '함양읍', districts: [hamyangDistricts]);
 City hampyeong = City(cityName: '함평읍', districts: [hampyeongDistricts]);
 City yeonggwang = City(cityName: '영광읍', districts: [yeonggwangDistricts]);
 City jangseong = City(cityName: '장성읍', districts: [jangseongDistricts]);
 City wando = City(cityName: '완도읍', districts: [wandoDistricts]);
 City jinsan = City(cityName: '진산읍', districts: [jinsanDistricts]);
 City sinan = City(cityName: '신안읍', districts: [sinanDistricts]);

// 전라남도 정보
 State_ jeollanamdo = State_(stateName: '전라남도', cities: [
  mokpo,
  yeosu,
  suncheon,
  nakan,
  damyang,
  gochang,
  gurye,
  goheung,
  boseong,
  hwasun,
  jangheung,
  gangjin,
  haenam,
  yeongam,
  muan,
  hamyang,
  hampyeong,
  yeonggwang,
  jangseong,
  wando,
  jinsan,
  sinan
]);