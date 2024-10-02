import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../dioBaseOptions.dart';

Future deleteRecentSearch(String term) async{
  await dotenv.load(fileName: ".env");
  String? apiKey = dotenv.env['API_KEY'];
  final res = await dio.delete(
    data: {
      'term' : term
    },
    '$apiKey/ranks/recent',
  );
  print(res);
  return res;
}