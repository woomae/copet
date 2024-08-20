import 'package:dio/src/response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../dioBaseOptions.dart';

Future<Response<dynamic>> postLikeRequest(String articleId) async {
  await dotenv.load(fileName: ".env");
  String? apiKey = dotenv.env['API_KEY'];
  final res = await dio.post(
      '$apiKey/stars/like-request',
      data: {
        'article_id' : articleId
      }
  );
  return res;
}