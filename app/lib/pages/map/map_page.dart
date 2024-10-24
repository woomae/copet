import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:pet/api/walkmamp/postWalkMap.dart';
import 'package:pet/common/component/dialogs/commonDialog.dart';
import 'package:pet/common/component/dialogs/confirmDialog.dart';
import 'package:pet/common/component/dialogs/saveDialog.dart';
import 'package:pet/common/component/widgets/spinner_widget.dart';
import 'package:pet/const/models/location_model.dart';
import 'package:pet/providers/location_provider.dart';
import 'package:pet/providers/pause_time_provider.dart';
import 'package:pet/providers/walk_map_notifier_provider.dart';
import 'package:pet/providers/walk_time_provider.dart';
import 'package:pet/utils/format_date.dart';
import 'package:pet/utils/update_zoom_to_show_all_path.dart';

import '../../providers/map_controller_provider.dart';
import '../../style/colors.dart';
import '../../utils/calculate_distance.dart';

final isTrackingProvider = StateProvider((ref)=>false);

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
                  bottom: 0,
                  child: NaverMapWidget()),
            ])));
  }
}

class NaverMapWidget extends ConsumerWidget {
  NaverMapWidget({super.key});
  final Completer<NaverMapController> mapControllerCompleter = Completer();
  late NaverMapController mapController;

  Future<void> requestLocationPermission(WidgetRef ref) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    final locationState = ref.read(LocationProvider);
    if (!serviceEnabled) {
      return Future.error('위치 기능을 사용할 수 없습니다.');
    } else {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('위치 권한이 없습니다.');
        }
      } else {
        if (locationState.longitude == 0 && locationState.latitude == 0) {
          Position currentPosition = await Geolocator.getCurrentPosition();
          ref.read(LocationProvider.notifier).state.latitude =
              currentPosition.latitude;
          ref.read(LocationProvider.notifier).state.longitude =
              currentPosition.longitude;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(children: [
      FutureBuilder(
          future: requestLocationPermission(ref),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SpinnerWidget();
            }
            if (snapshot.hasError) {
              return SizedBox();
            } else {
              return MapScreen();
            }
          }),
      BottomDrawer(context)
    ]);
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<NaverMapController> mapControllerCompleter = Completer();
  List<NLatLng> _pathPoints = [];
  Timer? _mockLocationTimer = null;
  double _totalDistance = 0.0;
  bool isWalking = false;

  @override
  void initState() {
    super.initState();
  }

  void _addNewLocation(NLatLng latLng) {
        setState(() {
          _pathPoints.add(latLng);
          double distance = calculateDistance(_pathPoints.last, latLng);
          _totalDistance += distance; // 총 거리 업데이트
          NPathOverlay(
              id: '${DateTime.now()}',
              coords: _pathPoints,
              color: PRIMARY_COLOR2,
              outlineColor: PRIMARY_COLOR2
          );
        });
  }

  void _startMockLocationUpdates(LocationModel state, NaverMapController _mapController, WidgetRef ref) {
    double _currentLat = state.latitude;
    double _currentLng = state.longitude;
    print('타이머 시작');
      _mockLocationTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          // 좌표를 약간씩 이동시켜서 경로가 생기도록 함
          _currentLat += Random().nextDouble() *0.0005;
          _currentLng += Random().nextDouble() *0.0005;
          double distance = calculateDistance(_pathPoints.last, NLatLng(_currentLat, _currentLng));
          _totalDistance += distance; // 총 거리 업데이트
          ref.read(WalkMapProvider.notifier).updateWalkMap(
              steps: _totalDistance.toInt()
          );
          print(_totalDistance);
          _pathPoints.add(NLatLng(_currentLat, _currentLng));
           if(_pathPoints.length > 1){
             _mapController.addOverlay(
                 NPathOverlay(
                   id: '${DateTime.now()}',
                   coords: _pathPoints,
                   color: PRIMARY_COLOR2,
                   outlineColor: PRIMARY_COLOR2,

                 )
             );
           }
        });
      });

  }
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget){
      final state = ref.read(LocationProvider);
      final isTrackingMode = ref.watch(isTrackingProvider);
      final mapController = ref.read(MapControllerProvider);
      return RepaintBoundary(
        child: NaverMap(
          options: NaverMapViewOptions(
            initialCameraPosition: NCameraPosition(
              target: NLatLng(state.latitude, state.longitude),
              zoom: 17,
              bearing: 0,
              tilt: 0,
            ),
            mapType: NMapType.basic,
            indoorEnable: true,
            consumeSymbolTapEvents: false,
          ),
          onMapReady: (NaverMapController _mapController) async {
            ref.read(MapControllerProvider.notifier).state =
                _mapController;
            mapControllerCompleter
                .complete(_mapController);
            print('Naver Map 로딩 완료');
            NLocationTrackingMode.face;
            _mapController.getLocationOverlay().setIsVisible(true);
          },
          onCameraChange:  (NCameraUpdateReason reason, bool animated) async {
            bool isAnimated = false;

            if(isTrackingMode == true){
              if(isWalking == false){
                //_pathPoints.add(NLatLng(state.latitude, state.longitude));
                //isWalking = true;
              }if(isWalking == true){
                //_addNewLocation(NLatLng(state.latitude, state.longitude));
              }
            }
            //---------------------목업 타이머 실행
            if(isTrackingMode == true && mapController != null && isWalking == false ){
              //mock 타이머 설정하는 부분
              _pathPoints.add(NLatLng(state.latitude, state.longitude));
              _startMockLocationUpdates(state, mapController,ref);
              isWalking = true;
            }
            //산책 종료 시
            if(isTrackingMode == false && mapController != null && isWalking == true){
              if(isWalking == true){
                isWalking = false;
                _totalDistance = 0.0;
                isAnimated = true;
                await updateCameraToShowAllPath(_pathPoints, mapController);
                isAnimated = false;


                Function initializeOverlays = (){
                  _pathPoints.clear();
                  mapController.clearOverlays();
                  isWalking = false;
                };

                if(isAnimated == false){
                  final File snapShot = await mapController.takeSnapshot(showControls: true);
                  saveDialog(context, snapShot, initializeOverlays).then((e){
                    initializeOverlays();
                    final String walkStartedAt = formatDateToYYYYMMDD(DateTime.now());
                    final walkMapState = ref.read(WalkMapProvider);
                    print(walkStartedAt);
                    print(walkMapState.steps);
                    print(walkMapState.durationSeconds);
                    print(snapShot);
                    try{
                      postWalkMaps(
                          walkStartedAt: walkStartedAt,
                          steps: walkMapState.steps,
                          durationSeconds: walkMapState.durationSeconds,
                          mapImg: snapShot
                      );
                    }catch(e){
                      print(e);
                    }
                  });
                }

                print('산책 종료');
              }
              //좌표, 오버레이 초기화
        
              //mock 타이머 초기화
              _mockLocationTimer?.cancel();
            }
          },
        ),
      );
    });
  }
}


class BottomDrawer extends ConsumerStatefulWidget {
  const BottomDrawer(this.mapContext, {super.key});
  final BuildContext mapContext;

  @override
  _BottomDrawerState createState() => _BottomDrawerState();
}

class _BottomDrawerState extends ConsumerState<BottomDrawer> {
  late double _height;
  late double _highLimit;
  final double _lowLimit = 50;
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
              final double mapHeight = widget.mapContext.size?.height ?? 800;
              _highLimit = mapHeight / 2.5;

              double? delta = details.primaryDelta;
              if (delta != null) {
                if (_isLongAnimation) return;
                setState(() {
                  if (_height == _lowLimit) {
                    _height = _highLimit;
                    _isLongAnimation = true;
                  } else if (_height == _highLimit) {
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
                  boxShadow: [
                    BoxShadow(color: GREY2, blurRadius: 5, spreadRadius: 0.7)
                  ],
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
                    margin: EdgeInsets.only(bottom: 15),
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

class _bottomSheetWidget extends ConsumerStatefulWidget {
  const _bottomSheetWidget({super.key});

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends ConsumerState<_bottomSheetWidget> {
  Timer? _timer;
  Duration _elapsedTime = Duration.zero;
  bool _isWalking = false;
  bool _isPaused = false; // 추가된 상태 변수

  @override
  Widget build(BuildContext context) {
    final _mapController = ref.watch(MapControllerProvider);
    final walkMapState = ref.watch(WalkMapProvider);
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _currentPositionButton(mapController: _mapController, context: context),
                  _pauseButton(context: context),
                  Spacer(),
                  _stopButton(mapController: _mapController, ref: ref)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _informationBox(
                      imagePath: 'asset/img/map/timer.png',
                      data: _formatDuration(_elapsedTime),
                      dataName: '산책 시간',
                      context: context
                  ),
                  _informationBox(
                      imagePath: 'asset/img/map/walkcount.png',
                      data: '0', // 걸음 수 초기값
                      dataName: '걸음 수',
                      context: context
                  ),
                  _informationBox(
                      imagePath: 'asset/img/map/distance.png',
                      data: walkMapState.steps.toString(), // 총 거리 초기값
                      dataName: '총 거리',
                      unit: ' km',
                      context: context

                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget _currentPositionButton({required mapController, required context}) {
    return TextButton(
        onPressed: () async {
          mapController?.updateCamera(NCameraUpdate.fromCameraPosition(
              NCameraPosition(
                  target: await mapController.getLocationOverlay().getPosition(),
                  zoom: 17
              )
          ));
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: GREY3,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.gps_fixed,
                color: WHITE.withOpacity(0.9),
              ),
              const SizedBox(height: 6),
              Text(
                  '현위치',
                  style: TextStyle(
                    fontFamily: 'MBC1961gulim',
                    fontWeight: FontWeight.w500,
                    fontSize: 8,
                    color: Colors.white.withOpacity(0.9),
                  )
              )
            ],
          ),
        )
    );
  }

  Widget _pauseButton({required context}) {
    return TextButton(
      onPressed: () {
        if (_isWalking) {
          if (_isPaused) {
            _resumeTimer();
          } else {
            _pauseTimer();
          }
        }
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isWalking ? (_isPaused ? PRIMARY_COLOR : GREY3) : PRIMARY_COLOR,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isWalking ? (_isPaused ? Icons.play_arrow : Icons.pause) : Icons.pause,
              color: WHITE.withOpacity(0.9),
            ),
            const SizedBox(height: 4),
            Text(
                _isWalking ? (_isPaused ? 'RESUME' : 'PAUSE') : 'PAUSE',
                style: TextStyle(
                  fontFamily: 'MBC1961gulim',
                  fontWeight: FontWeight.w500,
                  fontSize: 8,
                  color: Colors.white.withOpacity(0.9),
                )
            )
          ],
        ),
      ),
    );
  }

  Widget _informationBox({
    required BuildContext context,
    required String imagePath,
    required String data,
    required String dataName,
    String? unit, // 선택적 단위 추가
  }) {
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
                Image.asset(
                  imagePath,
                  width: 24,
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    unit == null
                        ? Text(
                      data,
                      style: TextStyle(
                        fontFamily: 'Segoe',
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF222222),
                        fontSize: 20,
                      ),
                    )
                        : Text.rich(
                      TextSpan(
                        text: data,
                        style: TextStyle(
                          fontFamily: 'Segoe',
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF222222),
                          fontSize: 20,
                        ),
                        children: [
                          TextSpan(
                            text: unit,
                            style: TextStyle(
                              fontFamily: 'Segoe', // 적용할 폰트 이름
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF222222),
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  dataName,
                  style: TextStyle(color: GREY3, fontSize: 12),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _stopButton({required NaverMapController? mapController, required WidgetRef ref}) {
    String walkingText = _isWalking ? 'FINISH' : 'START';
    Color walkingBackgroundColor = _isWalking ? WHITE : PRIMARY_COLOR;
    Color walkingIconColor = _isWalking ? PRIMARY_COLOR : WHITE;
    IconData walkingIcon = _isWalking ? Icons.stop_rounded : Icons.play_arrow;

    return TextButton(
      onPressed: () {
        //stop 클릭 시
        if (_isWalking) {
          ref.read(isTrackingProvider.notifier).state = false;
          print("산책 시간 : " + _elapsedTime.inSeconds.toString());
          ref.read(WalkMapProvider.notifier).updateWalkMap(
            durationSeconds: _elapsedTime.inSeconds
          );
          _stopTimer();
        } else {
          //start 클릭 시
          ref.read(isTrackingProvider.notifier).state = true;
          _startTimer();
        }
      },
      child: Container(
        width: 85,
        height: 85,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color(0xFFDD903E).withOpacity(0.2),
                blurRadius: 7.3,
                spreadRadius: 5
            )
          ],
          shape: BoxShape.circle,
          color: walkingBackgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              walkingIcon,
              color: walkingIconColor.withOpacity(0.9),
              size: 50,
            ),
            Text(
              walkingText,
              style: TextStyle(
                fontFamily: 'MBC1961gulim',
                fontWeight: FontWeight.w500,
                color: walkingIconColor.withOpacity(0.9),
                fontSize: 10,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime = _elapsedTime + Duration(seconds: 1);
      });
    });
    setState(() {
      _isWalking = true;
      _isPaused = false;
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isWalking = false;
      _isPaused = false;
      _elapsedTime = Duration.zero; // 또는 원하는 초기값
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isPaused = true;
    });
  }

  void _resumeTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime = _elapsedTime + Duration(seconds: 1);
      });
    });
    setState(() {
      _isPaused = false;
    });
  }

   _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}