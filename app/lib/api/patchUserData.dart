import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PatchUserData{

  static Future<Response> patchUserData({
    required int? userId,
    String? nickname,
    String? pet_category,
    String? region_do,
    String? region_si,
    String? region_dong,
    String? petimg,
    String? petkeyword,
    String? intro,
  }) async{

    String? region;
    region_do != null && region_si != null  && region_dong != null &&
    region_do != '' && region_si != '' && region_dong != ''
        ? region = region_do + '' + region_si + '' + region_dong : null;

    final FormData formData = FormData();
    if (nickname != null && nickname != '') formData.fields.add(MapEntry('nickname', nickname));
    if (pet_category != null && pet_category != '') formData.fields.add(MapEntry('pet_catagory', pet_category));
    if (region != null && region != '') formData.fields.add(MapEntry('region', region));
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