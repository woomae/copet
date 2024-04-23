import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PostPosting{

  static Future<void> postPosting({
    required int owner_id,
    required String title,
    required String body,
    required String category,
    List<String>? imagePaths
}) async{

    FormData formData = FormData.fromMap({
      'owner_id' : owner_id,
      'title' : title,
      'body' : body,
      'category' : category
    });

    if(imagePaths != null){
      final imageNames = imagePaths.map((e) => MultipartFile.fromFileSync(e)).toList();

      formData = FormData.fromMap({
        'owner_id' : owner_id,
        'title' : title,
        'body' : body,
        'category' : category,
        'image_name' : imageNames
      });
    }

    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];
    Dio dio = Dio();
    dio.options.contentType = 'multipart/form-data';
    final res = await Dio().post('$apiKey/articles/create',data: formData);
    print(res.data);
  }
}