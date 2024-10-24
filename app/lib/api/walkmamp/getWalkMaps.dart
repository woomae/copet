import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pet/const/models/walkmap_model.dart';

import '../dioBaseOptions.dart';

Future<List<WalkMap>> getWalkMaps() async{
  await dotenv.load(fileName: ".env");
  String? apiKey = dotenv.env['API_KEY'];
  final res = await dio.get(
      '$apiKey/walkmaps',
  );
  print(res);
  final List resList = res.data['result'];
  final List<WalkMap> walkMap = resList.map((e)=>WalkMap.fromJson(json:e)).toList();
  return walkMap;
}