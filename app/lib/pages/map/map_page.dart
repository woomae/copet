import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pet/common/component/widgets/spinner_widget.dart';
import 'package:pet/providers/location_provider.dart';
import 'package:pet/providers/pause_time_povider.dart';
import 'package:pet/providers/walk_time_provider.dart';

import '../../providers/map_controller_provider.dart';
import '../../style/colors.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
          child: Stack(children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 150),
              left: 0,
              right: 0,
              top: 0,
              bottom: 0, //drawerHeight - _drawerHandleHeight,
              child: NaverMapWidget()
            ),
          ]))
    );
  }
}

class NaverMapWidget extends ConsumerWidget {

  NaverMapWidget({super.key});
  // NaverMapController 객체의 비동기 작업 완료를 나타내는 Completer 생성
  final Completer<NaverMapController> mapControllerCompleter = Completer();
  late NaverMapController mapController;

  Future<void> requestLocationPermission(WidgetRef ref) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    final locationState = ref.read(LocationProvider);
    if (!serviceEnabled) {
      return Future.error('위치 기능을 사용할 수 없습니다.');
    }
    else{
      //위치 기능을 사용할 수 있을 때, 위치 권한 요청
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        //권한이 없는 경우
        permission = await Geolocator.requestPermission();
        print(permission.name);
        if (permission == LocationPermission.denied) {
          return Future.error('위치 권한이 없습니다.');
        }
      }
      else{
        if(locationState.longitude == 0 && locationState.latitude == 0){
          Position currentPosition = await Geolocator.getCurrentPosition();
          ref.read(LocationProvider.notifier).state.latitude = currentPosition.latitude;
          ref.read(LocationProvider.notifier).state.longitude = currentPosition.longitude;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        FutureBuilder(
          future: requestLocationPermission(ref),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return SpinnerWidget();
            }
            if(snapshot.hasError){
              return SizedBox();
            }
            else{
              final state = ref.watch(LocationProvider);
              return NaverMap(
                options: NaverMapViewOptions(
                  initialCameraPosition: NCameraPosition(
                    target: NLatLng(state.latitude, state.longitude),
                    zoom: 17,
                    bearing: 0,
                    tilt: 0,
                  ),
                  mapType: NMapType.basic,
                  indoorEnable: true,             // 실내 맵 사용 가능 여부 설정
                  consumeSymbolTapEvents: false,  // 심볼 탭 이벤트 소비 여부 설정
                ),
                onMapReady: (NaverMapController _mapController) async {
                  mapController = _mapController;
                  ref.read(MapControllerProvider.notifier).state = _mapController;
                  mapControllerCompleter.complete(mapController);  // Completer에 지도 컨트롤러 완료 신호 전송
                  print('Naver Map 로딩 완료');

                  NLocationTrackingMode.face;
                  mapController.getLocationOverlay().setIsVisible(true);

                },
              );
            }
      }),
        BottomDrawer(context)
      ]
    );
  }
}

class BottomDrawer extends StatefulWidget {
  const BottomDrawer(this.mapContext, {super.key});
  final BuildContext mapContext;
  @override
  State<BottomDrawer> createState() => _BottomDrawerState();
}

class _BottomDrawerState extends State<BottomDrawer> {
  late double _height;

  late double _highLimit;
  final double _lowLimit = 50;

  /// 100 -> 600, 550 -> 100 으로 애니메이션이 진행 될 때,
  /// 드래그로 인한 _height의 변화 방지
  bool _isLongAnimation = false;

  @override
  void initState() {
    super.initState();
    _height = _lowLimit;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0.0,
        child: GestureDetector(
            onVerticalDragUpdate: ((details) {
              final double mapHeight = widget.mapContext.size?.height  ?? 800;
              _highLimit = mapHeight / 2.5;

              // delta: y축의 변화량, 우리가 보기에 위로 움직이면 양의 값, 아래로 움직이면 음의 값
              double? delta = details.primaryDelta;
              print(delta);
              if (delta != null) {
                if (_isLongAnimation) return;
                setState(() {
                  /// 600으로 높이 설정
                  if (_height == _lowLimit) {
                    _height = _highLimit;
                    _isLongAnimation = true;
                  }
                  /// 100으로 높이 설정
                  else if (_height == _highLimit) {
                    _height = _lowLimit;
                    _isLongAnimation = true;
                  }
                });
              }
            }),
            child: AnimatedContainer(
              curve: Curves.ease,
              onEnd: () {
                if (_isLongAnimation) {
                  setState(() {
                    _isLongAnimation = false;
                  });
                }
              },
              duration: const Duration(milliseconds: 400),
              decoration: const BoxDecoration(
                  boxShadow: [BoxShadow(color:GREY2, blurRadius: 5, spreadRadius: 0.7)],
                  color: WHITE,
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(30))),
              width: MediaQuery.of(context).size.width,
              height: _height,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 70,
                    height: 4.5,
                    decoration: const BoxDecoration(
                        color: GREY2,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  _bottomSheetWidget()
                ],
              ),
            )));
  }
}

class _bottomSheetWidget extends ConsumerWidget {
  const _bottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _mapController = ref.read(MapControllerProvider);
    final _width = MediaQuery.of(context).size.width;

    int walkTime = ref.watch(WalkTimeProvider);
    int pauseTime = ref.watch(PauseTimeProvider);

    return Expanded(
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 10),
                Column( children: [
                  Text('150', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),),
                  Text('km/h', style: TextStyle(fontSize: 12, color: GREY3),)
                ],),
                SizedBox(width: 10,),
                _currentPositionButton(mapController: _mapController, context: context),
                _pauseButton(context: context),
                _stopButton()
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              _informationBox(
                  icon: Icons.lock_clock, data: walkTime.toString(), dataName: '산책 시간', context: context),
              _informationBox(
                  icon: Icons.stop, data: pauseTime.toString(), dataName: '일시정지 시간', context: context),
              _informationBox(
                  icon: Icons.timer, data: '', dataName: '최고 속도', context: context)
            ],)
          ],),
        ));
  }
 Widget _currentPositionButton({required mapController, required context}){
    return TextButton(
        onPressed: () async {
          mapController?.updateCamera(
              NCameraUpdate.fromCameraPosition(NCameraPosition(
                  target: await mapController.getLocationOverlay().getPosition()
                  , zoom: 17
              )));
        },
        child: Container(
          width: 60, height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: GREY2,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Icon(Icons.gps_fixed, color: WHITE,),
            Text('현위치', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: WHITE),)
          ],),
        )
    );
 }
 Widget _pauseButton({required context}){
    return TextButton(
      onPressed: () {

      },
      child: Container(
        width: 60, height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: PRIMARY_COLOR,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(Icons.pause, color: WHITE,),
          Text('일시정지', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: WHITE),)
        ],),
      ),
    );
 }
  Widget _informationBox({
    required BuildContext context,
    required IconData icon,
    required String data,
    required String dataName }){

    return SizedBox(
      width: (MediaQuery.of(context).size.width - 50) / 3,
      height: (MediaQuery.of(context).size.width - 50) / 2.7,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: GREY2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Icon(icon),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(data, style: Theme.of(context).textTheme.titleLarge,),
                ],
              ),
              Text(dataName, style: TextStyle(color: GREY3, fontSize: 12),)
            ],),
          ),
        ),
      ),
    );
  }
}

class _stopButton extends StatefulWidget {
  const _stopButton({super.key});

  @override
  State<_stopButton> createState() => _stopButtonState();
}

class _stopButtonState extends State<_stopButton> {
  late bool isWalking;

  @override
  void initState() {
    isWalking = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String walkingText = isWalking ? '산책종료' : '산책시작';
    Color walkingBackgroundColor = isWalking ? WHITE : PRIMARY_COLOR;
    Color walkingIconColor = isWalking ? PRIMARY_COLOR : WHITE;
    IconData walkingIcon = isWalking ? Icons.stop : Icons.play_arrow;
    return Consumer(builder: (BuildContext context, WidgetRef ref, widget){
      return TextButton(
          onPressed: () {
            if(isWalking){
              //산책 타이머 중단
              //일시정지 타이머 시작
            }
            else{
              //산책 타이머 시작
              //일시정지 타이머 중단
            }
            setState(() => isWalking = !isWalking);
          },
          child: Container(
            width: 85, height: 85,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(
                  color: walkingIconColor, blurRadius: 3, spreadRadius: 0.1)],
              shape: BoxShape.circle,
              color: walkingBackgroundColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(walkingIcon, color: walkingIconColor, size: 30,),
                SizedBox(height: 2),
                Text(walkingText, style: TextStyle(color: walkingIconColor, fontSize: 10),)
              ],),
          )
      );
    });
  }
}
