import 'package:dio/dio.dart';
import 'package:pet/const/models/posting_model.dart';

import '../const/models/users_model.dart';

class PostPosting{
  static Future<void> postPosting({
    required int owner_id,
    required String title,
    required String body,
    required String category
}) async{
    FormData formData = FormData.fromMap({
      'owner_id' : owner_id,
      'title' : title,
      'body' : body,
      'category' : category
    });

    final res = await Dio().post('https://dev.copet.life/articles/create',data: formData);
    print(res.data);

  }
}