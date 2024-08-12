import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/const/models/location_model.dart';

final LocationProvider = StateProvider<LocationModel>(
    (ref) => LocationModel(latitude: 0, longitude: 0)
);