import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/const/models/user_data_model.dart';
import 'package:pet/const/models/users_model.dart';

import '../const/models/region_model.dart';

final UserProvider = StateNotifierProvider<UserNotifier, UsersModel>(
        (ref) => UserNotifier());

class UserNotifier extends StateNotifier<UsersModel> {
  UserNotifier() :
        super( UsersModel(
          id: 0,
          nickname: '',
          petCategory: '',
          region: Region(state: '', city: '', district: ''),
          photo: [],
          petKeywords: [], //수정필요
          intro: '',
      ));

  void updateUser({
     int? id,
     String? nickname,
     String? petCategory,
     Region? region,
     List<String>? photo,
     List<PetKeyWords>? petKeywords,
     String? intro,

  }) {
    state = UsersModel(id: id ?? state.id,
        nickname: nickname ?? state.nickname,
        petCategory: petCategory ?? state.petCategory,
        region: region ?? state.region,
        photo: photo ?? state.photo,
        petKeywords: petKeywords ?? state.petKeywords,
        intro: intro ?? state.intro,
    );
  }

  void storeUserData(UsersModel data)  {
    print('Store User');
    if(state != data){
      state = UsersModel(
          id: data.id,
          nickname: data.nickname,
          petCategory: data.petCategory,
          region: data.region,
          photo: data.photo,
          petKeywords: data.petKeywords,
          intro: data.intro,
      );
    }
    else return;
  }
}
