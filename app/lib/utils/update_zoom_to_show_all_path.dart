import 'package:flutter/cupertino.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

Future<void> updateCameraToShowAllPath(List<NLatLng> _pathPoints, NaverMapController _mapController) async{
  print('카메라이동');
  if (_pathPoints.isNotEmpty) {
    // LatLngBounds 계산
    double southWestLat = _pathPoints[0].latitude;
    double southWestLng = _pathPoints[0].longitude;
    double northEastLat = _pathPoints[0].latitude;
    double northEastLng = _pathPoints[0].longitude;

    for (NLatLng point in _pathPoints) {
      if (point.latitude < southWestLat) {
        southWestLat = point.latitude;
      }
      if (point.longitude < southWestLng) {
        southWestLng = point.longitude;
      }
      if (point.latitude > northEastLat) {
        northEastLat = point.latitude;
      }
      if (point.longitude > northEastLng) {
        northEastLng = point.longitude;
      }
    }

    // 경계 설정
    NLatLngBounds bounds = NLatLngBounds(
      southWest: NLatLng(southWestLat, southWestLng),
      northEast: NLatLng(northEastLat, northEastLng),
    );

    // 카메라 애니메이션
    await _mapController.updateCamera(
      NCameraUpdate.fitBounds(bounds, padding: EdgeInsets.all(180)),
    );
  }
}