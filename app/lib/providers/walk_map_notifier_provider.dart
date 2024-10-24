import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/utils/format_date.dart';
import '../const/models/walkmap_model.dart';

final WalkMapProvider = StateNotifierProvider<WalkMapNotifier, WalkMap>(
        (ref) => WalkMapNotifier());

class WalkMapNotifier extends StateNotifier<WalkMap> {
  WalkMapNotifier() :
        super(
          WalkMap(
          id: 0,
          walkStartedAt: formatDateToYYYYMMDD(DateTime.now()),
          steps: 0,
          durationSeconds: 0,
          createdAt: DateTime.now()
      ));
  void updateWalkMap(
      {String? walkStartedAt,int? steps,int? durationSeconds,DateTime? createdAt, String? photo}) {
    state = WalkMap(
        id: 0,
        walkStartedAt: walkStartedAt ?? state.walkStartedAt,
        steps: steps ?? state.steps,
        durationSeconds: durationSeconds ?? state.durationSeconds,
        createdAt: createdAt ?? state.createdAt,
        photo: photo ?? state.photo
    );
  }
}