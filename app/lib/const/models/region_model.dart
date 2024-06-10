import 'package:pet/const/regions/jellanamdo/jeollanamdo.dart';

class Region {
  final State_? state;
  final City? city;
  final District? district;

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
  final List<District> districts;
  City({required this.cityName, required this.districts});

  static City? getCityByString(String e){
    switch(e){
      case '목포':
        return mokpo;
    }
    return null;
  }
}
class District{
  final List districtName;
  District({required this.districtName});
}