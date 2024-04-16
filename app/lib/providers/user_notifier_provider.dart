import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/const/models/users_model.dart';

final UserProvider = StateNotifierProvider<UserNotifier, UsersModel>(
        (ref) => UserNotifier());

class UserNotifier extends StateNotifier<UsersModel> {
  UserNotifier() :
        super( UsersModel(
          id: 0,
          nickname: '',
          email: '',
          pet_category: '',
          region: '',
          petimg: '',
          petkeyword: '', //수정필요
          intro: '',
          created_at: DateTime.now(),
          updated_at: DateTime.now()
      ));
  void updateUser({
     int? id,
     String? nickname,
     String? email,
     String? pet_category,
     String? region,
     String? petimg,
     String? petkeyword,
     String? intro,
     DateTime? created_at,
     DateTime? updated_at,
  }) {
    state = UsersModel(id: id ?? state.id,
        nickname: nickname ?? state.nickname,
        email: email ?? state.email,
        pet_category: pet_category ?? state.pet_category,
        region: region ?? state.region,
        petimg: petimg ?? state.petimg,
        petkeyword: petkeyword ?? state.petkeyword,
        intro: intro ?? state.intro,
        created_at: created_at ?? state.created_at,
        updated_at: updated_at ?? state.updated_at);
  }

  void storeUserData(UsersModel data)  {
    state = UsersModel(
        id: data.id,
        nickname: data.nickname,
        email: data.email,
        pet_category: data.pet_category,
        region: data.region,
        petimg: data.petimg,
        petkeyword: data.petkeyword,
        intro: data.intro,
        created_at: data.created_at,
        updated_at: data.updated_at
    );
  }
}
