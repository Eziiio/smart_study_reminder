import 'dart:async';
import 'package:vibration/vibration.dart';

import 'notification_service.dart';

class InactivityService {
  InactivityService({
    required this.idleDuration,
  });

  final Duration idleDuration;
  Timer? _timer;

  /// Call this on any user interaction (tap, scroll, etc.)
  void registerUserInteraction() {
    _timer?.cancel();
    _timer = Timer(idleDuration, _onIdle);
  }

  void _onIdle() async {
    // Show local notification
    await NotificationService().showAlert();

    // Vibrate if available
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 500);
    }
  }

  void dispose() {
    _timer?.cancel();
  }
}
