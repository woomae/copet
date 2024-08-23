import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../dioBaseOptions.dart';

class DeleteComment{
  static deleteComment(String commentId) async{
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];

    final res = await dio.delete('$apiKey/comments/$commentId');
    print(res);
  }
}