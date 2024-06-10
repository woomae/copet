import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/const/models/user_data_model.dart';

import '../const/models/region_model.dart';

final userDataProvider = StateNotifierProvider<UserDataNotifier, UserDataModel>(
        (ref) => UserDataNotifier());

class UserDataNotifier extends StateNotifier<UserDataModel> {
  UserDataNotifier() :
        super( UserDataModel(
          nickname: null,
          pet_category: null,
          region: null,
          photo: null,
          petkeyword: null, //수정필요
          intro: null,
      ));
  void updateUserData({
    String? nickname,
    String? pet_category,
    Region? region,
    State_? state_,
    City? city,
    District? district,
    String? photo,
    List<PetKeyWords>? petkeyword,
    String? intro,
  }) {
    state = UserDataModel(
        nickname: nickname ?? state.nickname,
        pet_category: pet_category ?? state.pet_category,
        region: Region(state: state_ ?? state.region?.state, city: city ?? state.region?.city, district: district?.districtName[0] ?? state.region?.district),
        photo: photo ?? state.photo,
        petkeyword: petkeyword ?? state.petkeyword,
        intro: intro ?? state.intro
    );
  }
}