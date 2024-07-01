import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DeleteComment{
  static deleteComment(String commentId) async{
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];

    final res = await Dio().delete('$apiKey/comments/$commentId');
    print(res);
  }
}