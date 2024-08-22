import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../dioBaseOptions.dart';

Future postRecentSearches(String term) async{
  await dotenv.load(fileName: ".env");
  String? apiKey = dotenv.env['API_KEY'];
  final res = await dio.post(
    data: {
      "term" : term
    },
    '$apiKey/ranks',
  );
  print(res);
  return res;
}