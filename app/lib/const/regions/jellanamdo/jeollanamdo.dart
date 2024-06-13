// 전라남도의 각 시/군의 구/읍/면 정보
import '../../models/region_model.dart';

District mokpoDistricts = District(districtName: ['목포시']);
District yeosuDistricts = District(districtName: ['여수시']);
District suncheonDistricts = District(districtName: [
 '승주읍',
 '해룡면',
 '서면',
 '황전면',
 '월등면',
 '주암면',
 '송광면',
 '외서면',
 '낙안면',
 '별량면',
 '상사면',
 '중앙동',
 '도사동',
 '동외동',
 '남제동',
 '저전동',
 '장천동',
 '덕연동',
 '풍덕동',
 '왕조1동',
 '왕조2동']);
District najuDistricts = District(districtName: ['나주시']);
District gwangyangDistricts = District(districtName: ['광양시']);
District damyangDistricts = District(districtName: ['담양읍']);
District gokseongDistricts = District(districtName: ['곡성읍']);
District guryeDistricts = District(districtName: ['구례읍']);
District goheungDistricts = District(districtName: ['고흥읍']);
District boseongDistricts = District(districtName: ['보성읍']);
District hwasunDistricts = District(districtName: ['화순읍']);
District jangheungDistricts = District(districtName: ['장흥읍']);
District gangjinDistricts = District(districtName: ['강진읍']);
District haenamDistricts = District(districtName: ['해남읍']);
District yeongamDistricts = District(districtName: ['영암읍']);
District muanDistricts = District(districtName: ['무안읍']);
District hampyeongDistricts = District(districtName: ['함평읍']);
District yeonggwangDistricts = District(districtName: ['영광읍']);
District jangseongDistricts = District(districtName: ['장성읍']);
District wandoDistricts = District(districtName: ['완도읍']);
District jindoDistricts = District(districtName: ['진도읍']);
District sinanDistricts = District(districtName: ['신안읍']);

// 전라남도의 각 시/군 정보
City mokpo = City(cityName: '목포시', districts: mokpoDistricts);
City yeosu = City(cityName: '여수시', districts: yeosuDistricts);
City suncheon = City(cityName: '순천시', districts: suncheonDistricts);
City naju = City(cityName: '나주시', districts: najuDistricts);
City gwangyang = City(cityName: '광양시', districts: gwangyangDistricts);
City damyang = City(cityName: '담양군', districts: damyangDistricts);
City gokseong = City(cityName: '곡성군', districts: gokseongDistricts);
City gurye = City(cityName: '구례군', districts: guryeDistricts);
City goheung = City(cityName: '고흥군', districts: goheungDistricts);
City boseong = City(cityName: '보성군', districts: boseongDistricts);
City hwasun = City(cityName: '화순군', districts: hwasunDistricts);
City jangheung = City(cityName: '장흥군', districts: jangheungDistricts);
City gangjin = City(cityName: '강진군', districts: gangjinDistricts);
City haenam = City(cityName: '해남군', districts: haenamDistricts);
City yeongam = City(cityName: '영암군', districts: yeongamDistricts);
City muan = City(cityName: '무안군', districts: muanDistricts);
City hampyeong = City(cityName: '함평군', districts: hampyeongDistricts);
City yeonggwang = City(cityName: '영광군', districts: yeonggwangDistricts);
City jangseong = City(cityName: '장성군', districts: jangseongDistricts);
City wando = City(cityName: '완도군', districts: wandoDistricts);
City jindo = City(cityName: '진도군', districts: jindoDistricts);
City sinan = City(cityName: '신안군', districts: sinanDistricts);


// 전라남도 정보
State_ jeollanamdo = State_(stateName: '전라남도', cities: [
 mokpo,
 yeosu,
 suncheon,
 naju,
 gwangyang,
 damyang,
 gokseong,
 gurye,
 goheung,
 boseong,
 hwasun,
 jangheung,
 gangjin,
 haenam,
 yeongam,
 muan,
 hampyeong,
 yeonggwang,
 jangseong,
 wando,
 jindo,
 sinan
]);