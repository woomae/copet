import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PatchComment{
  static patchComment({required String commentId, required String comment}) async{
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];

    final res = await Dio().patch(
        '$apiKey/articles/$commentId',
      data: {
          "comment" : comment
      }
    );
    print(res);
  }
}