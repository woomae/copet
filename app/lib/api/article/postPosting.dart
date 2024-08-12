import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

import '../../const/models/articles.dart';
import '../dioBaseOpstions.dart';

class PostPosting{

  static Future<Response> postPosting({
    required String title,
    required String body,
    required String category,
    List<Photo>? images
}) async{

    FormData formData = FormData.fromMap({
      'title' : title,
      'body' : body,
      'category' : category
    });

    if(images != null){
      for (var image in images) {
        // MultipartFile 객체 생성 및 FormData에 추가
        formData.files.add(MapEntry(
          'photo',
          await MultipartFile.fromFile(image.imgPath),
        ));
      }
    }

    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];
    dio.options.contentType = 'multipart/form-data';
    final res = await dio.post('$apiKey/articles',data: formData);
    print('-----------------------------------------------------------------$res');
    return res;
  }
}