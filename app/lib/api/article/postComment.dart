import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../dioBaseOpstions.dart';

class PostComment{
  static postComment({required String articleId, required String comment}) async{
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];

    final res = await dio.post(
        '$apiKey/comment',
        data: {
          "comment" : comment
        },
      queryParameters: {'id': articleId}
    );
    print(res);
  }
}