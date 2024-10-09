import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/src/response.dart';

import '../dioBaseOptions.dart';

Future<Response<dynamic>> postWalkMaps({
  required String walkStartedAt,
  required int steps,
  required int durationSeconds,
  required mapImg
}) async{
  await dotenv.load(fileName: ".env");
  String? apiKey = dotenv.env['API_KEY'];
  final res = await dio.post(
    '$apiKey/walkmaps',
    data: {
      "walk_started_at" : walkStartedAt,
      "steps" : steps,
      "duration_seconds" : durationSeconds,
      "mapimg" : mapImg
    }
  );
  print(res);

  return res;
}