import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

import '../../const/models/articles.dart';
import '../dioBaseOpstions.dart';

class PutArticle{

  static Future<Response> putArticle({
    required String articleId,
    required String title,
    required String body,
    required String category,
    List<String>? prePhotos,
    List? nextPhotos,
  }) async{

    FormData formData = FormData.fromMap({
      'title' : title,
      'body' : body,
      'category' : category
    });

    if(prePhotos != null){
      formData = FormData.fromMap({
        'title' : title,
        'body' : body,
        'category' : category,
        'delete_img' : prePhotos
       });
    }

    if(nextPhotos != null){
      for (var image in nextPhotos) {
        // MultipartFile 객체 생성 및 FormData에 추가
        if(nextPhotos is Photo){
          formData.files.add(MapEntry(
            'photo',
            await MultipartFile.fromFile(image.imgPath),
          ));
        }
        else if(nextPhotos is String){
          formData.fields.add(MapEntry(
              'photo', image
          ));
        }
      }
    }else{
      formData.fields.add(MapEntry('photo', '[]'));
    }

    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];
    dio.options.contentType = 'multipart/form-data';
    final res = await dio.put('$apiKey/articles/$articleId',data: formData);
    print('-----------------------------------------------------------------$res');
    return res;
  }
}