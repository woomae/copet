import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dioBaseOpstions.dart';

Future postDiviceToken(String token) async{
  await dotenv.load(fileName: ".env");
  String? apiKey = dotenv.env['API_KEY'];
  final res = await dio.post(
      '$apiKey/users/save-token',
      data: {
        'token' : token
      }
  );
  return res;
}