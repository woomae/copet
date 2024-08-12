import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
      formData.fields.add(MapEntry(
        'delete_img',
        jsonEncode(prePhotos),
      ));
    }

    if(nextPhotos != null){
      for (var image in nextPhotos) {
        final imgPath = image is String ? image : image.imgPath;
        // MultipartFile 객체 생성 및 FormData에 추가
        if(isLocalPath(imgPath)){
          print('local임');
          formData.files.add(MapEntry(
            'photo',
            await MultipartFile.fromFile(imgPath),
          ));
        }
        else if(isNetworkUrl(imgPath)){
          print('네트워크uri임');
          final imageBytes = await _downloadImage(imgPath);
          formData.files.add(MapEntry(
            'photo',
            MultipartFile.fromBytes(imageBytes),
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

  static Future<Uint8List> _downloadImage(String url) async {
    final Dio dio = Dio();
    final response = await dio.get(
      url,
      options: Options(responseType: ResponseType.bytes),
    );

    print('downloadImage res : $response');
    if (response.statusCode == 200) {
      return response.data!;
    } else {
      throw Exception('Failed to load image');
    }
  }

  static bool isNetworkUrl(String path) {
    final uri = Uri.tryParse(path);
    return uri != null && (uri.isAbsolute && (uri.scheme == 'http' || uri.scheme == 'https'));
  }
  static bool isLocalPath(String path) {
    return path.startsWith('/') || path.contains('\\');
  }
}