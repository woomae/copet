import 'dart:math';

import 'package:flutter_naver_map/flutter_naver_map.dart';

double calculateDistance(NLatLng point1, NLatLng point2) {
  const double earthRadius = 6371; // 지구의 반지름 (킬로미터 단위)

  double dLat = _degreesToRadians(point2.latitude - point1.latitude);
  double dLon = _degreesToRadians(point2.longitude - point1.longitude);

  print('dLat: $dLat, dLon: $dLon'); // Debuggin

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(_degreesToRadians(point1.latitude)) *
          cos(_degreesToRadians(point2.latitude)) *
          sin(dLon / 2) *
          sin(dLon / 2);

  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return earthRadius * c; // 거리 (킬로미터 단위)
}

double _degreesToRadians(double degrees) {
  return degrees * pi / 180;
}