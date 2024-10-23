import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import '../dioBaseOptions.dart';

Future<Response<dynamic>> postWalkMaps({
  required String walkStartedAt,
  required int steps,
  required int durationSeconds,
  required File mapImg,
}) async {
  await dotenv.load(fileName: ".env");
  String? apiKey = dotenv.env['API_KEY'];

  FormData formData = FormData.fromMap({
    "walk_started_at": walkStartedAt,
    "steps": steps,
    "duration_seconds": durationSeconds,
    "mapimg": await MultipartFile.fromFile(mapImg.path),
  });

  final res = await dio.post(
    '$apiKey/walkmaps',
    data: formData,
    options: Options(contentType: 'multipart/form-data'), // multipart/form-data 설정
  );

  print(res);

  return res;
}
