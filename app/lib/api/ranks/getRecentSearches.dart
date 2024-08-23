import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../dioBaseOptions.dart';

Future<List<String>> getRecentSearches() async{
  await dotenv.load(fileName: ".env");
  String? apiKey = dotenv.env['API_KEY'];
  final res = await dio.get(
      '$apiKey/ranks/recent',
  );
  print('get : $res');
  List<String> resultList = (res.data['result'] as List<dynamic>).cast<String>() ?? [];
  return resultList;
}