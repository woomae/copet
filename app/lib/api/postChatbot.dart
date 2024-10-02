import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dioBaseOptions.dart';

Future<String> postChatbot(String message) async{
  await dotenv.load(fileName: ".env");
  String? apiKey = dotenv.env['API_KEY'];
  final res = await dio.post(
      '$apiKey/chatbot',
      queryParameters: {
        'message' : message
      }
  );
  final String answer = res.data['result'].toString();
  return answer;
}