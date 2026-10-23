import 'package:flutter/material.dart';

import '../../../../core/logic/helper_methods.dart';
import 'on_boarding_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    goTo(page: const OnBoardingView(), second: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', height: 200, width: 200),
            const SizedBox(height: 15),
            const Text(
              "C O S M E T I C S",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff434C6D),
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              "the company for women",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w200,
                color: Color(0xff434C6D),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
