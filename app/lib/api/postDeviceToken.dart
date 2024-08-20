import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dioBaseOptions.dart';

Future postDeviceToken(String token) async{
  await dotenv.load(fileName: ".env");
  String? apiKey = dotenv.env['API_KEY'];
  final res = await dio.post(
      '$apiKey/users/save-token',
      data: {
        "token" : token
      }
  );
  print(res.data);
  return res;
}