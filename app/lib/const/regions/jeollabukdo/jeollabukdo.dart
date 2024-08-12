import '../../models/region_model.dart';

District jeonjuDistricts = District(districtName: ['전주시']);
District gunsanDistricts = District(districtName: ['군산시']);
District ikkasanDistricts = District(districtName: ['익산시']);
District jeongeupDistricts = District(districtName: ['정읍시']);
District kimjaeDistricts = District(districtName: ['김제시']);
District namwonDistricts = District(districtName: ['남원시']);
District wanjuDistricts = District(districtName: ['완주군']);
District gachangDistricts = District(districtName: ['고창군']);
District buanDistricts = District(districtName: ['부안군']);
District imsilDistricts = District(districtName: ['임실군']);
District sunchangDistricts = District(districtName: ['순창군']);
District jinanDistricts = District(districtName: ['진안군']);
District mujooDistricts = District(districtName: ['무주군']);
District jangsooDistricts = District(districtName: ['장수군']);

City jeonju = City(cityName: '전주시', districts: jeonjuDistricts);
City gunsan = City(cityName: '군산시', districts: gunsanDistricts);
City ikkasan = City(cityName: '익산시', districts: ikkasanDistricts);
City jeongeup = City(cityName: '정읍시', districts: jeongeupDistricts);
City kimjae = City(cityName: '김제시', districts: kimjaeDistricts);
City namwon = City(cityName: '남원시', districts: namwonDistricts);
City wanju = City(cityName: '완주군', districts: wanjuDistricts);
City gachang = City(cityName: '고창군', districts: gachangDistricts);
City buan = City(cityName: '부안군', districts: buanDistricts);
City imsil = City(cityName: '임실군', districts: imsilDistricts);
City sunchang = City(cityName: '순창군', districts: sunchangDistricts);
City jinan = City(cityName: '진안군', districts: jinanDistricts);
City mujoo = City(cityName: '무주군', districts: mujooDistricts);
City jangsoo = City(cityName: '장수군', districts: jangsooDistricts);

State_ jeollabukdo = State_(stateName: '전라북도', cities: [
  jeonju,
  gunsan,
  ikkasan,
  jeongeup,
  kimjae,
  namwon,
  wanju,
  gachang,
  buan,
  imsil,
  sunchang,
  jinan,
  mujoo,
  jangsoo,
]);