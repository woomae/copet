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
          pet_category: '',
          region: Region(state: '', city: '', district: ''),
          petimg: [],
          petkeyword: [], //수정필요
          intro: '',
      ));
  void updateUser({
     int? id,
     String? nickname,
     String? email,
     String? pet_category,
     Region? region,
     List? petimg,
     List<String>? petkeyword,
     String? intro,

  }) {
    state = UsersModel(id: id ?? state.id,
        nickname: nickname ?? state.nickname,
        pet_category: pet_category ?? state.pet_category,
        region: region ?? state.region,
        petimg: petimg ?? state.petimg,
        petkeyword: petkeyword ?? state.petkeyword,
        intro: intro ?? state.intro,
    );
  }

  void storeUserData(UsersModel data)  {
    if(state.id != data.id){
      state = UsersModel(
          id: data.id,
          nickname: data.nickname,
          pet_category: data.pet_category,
          region: data.region,
          petimg: data.petimg,
          petkeyword: data.petkeyword,
          intro: data.intro,
      );
    }
    else return;
  }
}
