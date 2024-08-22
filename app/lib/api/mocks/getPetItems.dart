import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pet/const/models/merchandises.dart';

import '../dioBaseOptions.dart';

Future<Merchandises> getPetItems() async{
  await dotenv.load(fileName: ".env");
  String? apiKey = dotenv.env['API_KEY'];
  final res = await dio.get(
      '$apiKey/mocks/merchandises',
  );
  print(res);
  final Merchandises parsedRes = Merchandises.fromJson(res.data['result']);
  return parsedRes;
}