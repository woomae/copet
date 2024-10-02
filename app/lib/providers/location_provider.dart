import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/const/models/location_model.dart';

final LocationProvider = StateProvider<LocationModel>(
      (ref) => LocationModel(
    latitude: 34.96785522355779,  // 원하는 위도
    longitude: 127.48234735321462, // 원하는 경도
  ),
);
