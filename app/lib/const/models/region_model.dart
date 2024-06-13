import 'package:pet/const/regions/jellanamdo/jeollanamdo.dart';
import 'package:pet/const/regions/jeollabukdo/jeollabukdo.dart';

class Region {
  final String? state;
  final String? city;
  final String? district;

  Region({required this.state, required this.city, required this.district});

}

class State_ {
  final String stateName;
  final List<City> cities;
  State_({required this.stateName, required this.cities});
  static State_? getStateByName(State_ state){
    switch(state.stateName){
      case '전라남도':
        return jeollanamdo;
    }
    return null;
  }

  static State_? getStateByString(String e){
    switch(e){
      case '전라남도':
        return jeollanamdo;
    }
    return null;
  }
}

class City {
  final String cityName;
  final District districts;
  City({required this.cityName, required this.districts});

  static List<String>? getCityListByString(String? e){
    switch(e){
      case '전라남도':
        return jeollanamdo.cities.map((e) => e.cityName).toList();
      case '전라북도':
        return jeollabukdo.cities.map((e) => e.cityName).toList();
    }
    return null;
  }
}
class District{
  final List<String> districtName;
  District({required this.districtName});
  static List<String>? getDistrictListByString(String? e){
    switch(e){
      case '순천시':
        return suncheon.districts.districtName;
      case '목포시':
        return mokpo.districts.districtName;
    }
    return null;
  }
}