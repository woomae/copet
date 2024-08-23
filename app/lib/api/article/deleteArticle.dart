import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../dioBaseOptions.dart';

class DeleteArticle{
  static deleteArticle(String articleId) async{
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];

    final res = await dio.delete('$apiKey/articles/$articleId');
    print(res);
  }
}