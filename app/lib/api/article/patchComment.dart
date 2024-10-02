import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../dioBaseOptions.dart';

class PatchComment{
  static patchComment({required String commentId, required String comment}) async{
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];

    final res = await dio.patch(
        '$apiKey/articles/$commentId',
      data: {
          "comment" : comment
      }
    );
    print(res);
  }
}