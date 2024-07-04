import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/api/getUser.dart';
import 'package:pet/providers/user_notifier_provider.dart';

import '../main/main_home.dart';

class LoadingPage extends ConsumerWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.read(UserProvider);
    print(state.id);
    final res = GetUser.getUser(state.id.toString())
        .then((value){
          ref.read(UserProvider.notifier).storeUserData(value);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => mainhome()),
                (Route<dynamic> route) => false,
          );
        })
        .onError((error, stackTrace){
          print(error);
          ref.invalidate(UserProvider);
          Navigator.pop(context);
    });
    return IgnorePointer(
      child: CircularProgressIndicator(
        strokeWidth: 10,
      ),
    );
  }
}
