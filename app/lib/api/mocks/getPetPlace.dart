import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pet/const/models/pet_place.dart';

import '../dioBaseOptions.dart';

Future<PetPlaces> getPetPlace() async{
  await dotenv.load(fileName: ".env");
  String? apiKey = dotenv.env['API_KEY'];
  final res = await dio.get(
    '$apiKey/mocks/petPlaces',
  );
  final PetPlaces parsedData = PetPlaces.fromJson(res.data['result']);
  return parsedData;
}