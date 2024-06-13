import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pet/const/models/user_data_model.dart';

import '../const/models/region_model.dart';

class PatchUserData{

  static Future<Response> patchUserData({
    required int? userId,
    String? nickname,
    String? pet_category,
    Region? region,
    String? petimg,
    String? petkeyword,
    String? intro,
  }) async{

//districtName 수정 필요

    final FormData formData = FormData();
    if (nickname != null && nickname != '') formData.fields.add(MapEntry('nickname', nickname));
    if (pet_category != null && pet_category != '') formData.fields.add(MapEntry('pet_catagory', pet_category));
    if (region != null) {
      if (region.state != null) formData.fields.add(MapEntry('region_state', region.state!));
      if (region.city != null) formData.fields.add(MapEntry('region_city', region.city!));
      if (region.district != null) formData.fields.add(MapEntry('region_district', region.district!));
    }
    if (petkeyword != null && petkeyword !='') formData.fields.add(MapEntry('petkeyword', petkeyword));
    if (intro != null && intro != '') formData.fields.add(MapEntry('intro', intro));
    if (petimg != null) formData.files.add(MapEntry('petimg', MultipartFile.fromFileSync(petimg)));

    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];
    final res = await Dio().patch(
        '$apiKey/users/$userId/init',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          }
        )
    );
    print(res);
    return res;
  }
}