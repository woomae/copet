import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

class PostPosting{

  static Future<Response> postPosting({
    required int owner_id,
    required String title,
    required String body,
    required String category,
    List? images
}) async{

    FormData formData = FormData.fromMap({
      'owner_id' : owner_id,
      'title' : title,
      'body' : body,
      'category' : category
    });

    if(images != null){
      List<MultipartFile> imageNames = [];
      for (var file in images) {
        String fileName = file.path.split('/').last;
        MultipartFile multipartFile = await MultipartFile.fromFile(file.path, filename: fileName);
        imageNames.add(multipartFile);
      }

      formData = FormData.fromMap({
        'owner_id' : owner_id,
        'title' : title,
        'body' : body,
        'category' : category,
        'img_name' : imageNames
      });
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