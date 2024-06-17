import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../const/models/comments_model.dart';

class GetComments {
  static Future<Comments> getComments({required int id}) async {
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];

    final res = await Dio().get('$apiKey/comments/$id');
    print(res);
    final count = res.data['result'][0]['count'];
    final List commentList = res.data['result'][1];
    final List<Comment> comment = commentList.map((e) => Comment.fromJson(e))
        .toList();
    final Comments comments = Comments(count: count, comments: comment);
    print(comments.comments);
    print(comments.count);
    return comments;
  }
}