import 'package:flutter/material.dart';

import '../services/inactivity_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final InactivityService _inactivity;

  @override
  void initState() {
    super.initState();
    _inactivity = InactivityService(idleDuration: const Duration(seconds: 20));
    // Kick‑off the idle timer at start
    _inactivity.registerUserInteraction();
  }

  @override
  void dispose() {
    _inactivity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _inactivity.registerUserInteraction,
      onPanDown: (_) => _inactivity.registerUserInteraction(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Smart Study Reminder'),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Keep studying! We\'ll nudge you if you go idle for 20 seconds. Tap or scroll to reset the timer.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
