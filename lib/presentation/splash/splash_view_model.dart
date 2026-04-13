import 'dart:async';

import 'package:flutter/foundation.dart';

import '../base/base_view_model.dart';

class SplashViewModel extends BaseViewModel {
  SplashViewModel({required this.onFinished, Duration delay = const Duration(seconds: 3)})
    : _delay = delay {
    _start();
  }

  final VoidCallback onFinished;
  final Duration _delay;

  Timer? _timer;

  void _start() {
    _timer = Timer(_delay, onFinished);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
