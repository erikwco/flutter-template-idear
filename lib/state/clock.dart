import 'package:flutter_riverpod/flutter_riverpod.dart';

final clockProvider = StreamProvider<DateTime>((ref) async* {
  while (true) {
    yield DateTime.now();
    await Future.delayed(const Duration(seconds: 1));
  }
});
