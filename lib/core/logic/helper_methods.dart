import 'dart:async';

import 'package:flutter/material.dart';

final navKey = GlobalKey<NavigatorState>();

void goTo({required Widget page, bool keepHistory = false, int? second}) {
  void action() {
    Navigator.of(navKey.currentContext!).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (route) => keepHistory,
    );
  }

  if (second == null) {
    action();
  } else {
    Timer(Duration(seconds: second), () {
      action();
    });
  }
}
