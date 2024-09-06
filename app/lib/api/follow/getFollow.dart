import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../const/models/friends_model.dart';
import '../dioBaseOptions.dart';

Future<Friends> getFollow() async{
  await dotenv.load(fileName: ".env");
  String? apiKey = dotenv.env['API_KEY'];
  final res = await dio.get(
    '$apiKey/friends/follow',
  );
  final Friends follow = Friends.fromJson(res.data);
  return follow;
}