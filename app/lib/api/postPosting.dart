import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

class PostPosting{

  static Future<Response> postPosting({
    required int owner_id,
    required String title,
    required String body,
    required String category,
    List<XFile>? images
}) async{

    FormData formData = FormData.fromMap({
      'owner_id' : owner_id,
      'title' : title,
      'body' : body,
      'category' : category
    });

    if(images != null){
      for (var image in images) {
        // XFile에서 파일 이름을 가져오기 위해 path를 사용
        String fileName = image.path.split('/').last;

        // MultipartFile 객체 생성 및 FormData에 추가
        formData.files.add(MapEntry(
          'img_name',
          await MultipartFile.fromFile(image.path, filename: fileName),
        ));
      }
    }

    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];
    Dio dio = Dio();
    dio.options.contentType = 'multipart/form-data';
    final res = await dio.post('$apiKey/articles/create',data: formData);
    print('-----------------------------------------------------------------$res');
    return res;
  }
}