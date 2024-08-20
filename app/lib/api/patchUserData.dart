import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../const/models/region_model.dart';
import 'dioBaseOptions.dart';

class PatchUserData{

  static Future<Response> patchUserData({
    String? nickname,
    String? pet_category,
    Region? region,
    String? petimg,
    List<String>? petkeyword,
    String? intro,
  }) async{

//districtName 수정 필요

    final FormData formData = FormData();
    if (nickname != null && nickname != '') formData.fields.add(MapEntry('nickname', nickname));
    if (pet_category != null && pet_category != '') formData.fields.add(MapEntry('pet_category', pet_category));
    if (region != null) {
      if (region.state != null) formData.fields.add(MapEntry('region[state]', region.state!));
      if (region.city != null) formData.fields.add(MapEntry('region[city]', region.city!));
      if (region.district != null) formData.fields.add(MapEntry('region[district]', region.district!));
    }
    if (petkeyword != null ) {
        formData.fields.add(MapEntry('petkeyword', jsonEncode(petkeyword)));
    }
    if (intro != null && intro != '') formData.fields.add(MapEntry('intro', intro));
    if (petimg != null) formData.files.add(MapEntry('petimg', MultipartFile.fromFileSync(petimg)));

    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];

    final res = await dio.patch(
        '$apiKey/users/',
        data: formData,
    );
    print(res);
    return res;
  }
}