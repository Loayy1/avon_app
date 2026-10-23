import 'package:flutter/material.dart';

import '../../../../core/logic/helper_methods.dart';
import 'login_view.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  int currentPage = 0;
  final list = [
    _Collection(
      img: "assets/images/on_boarding1.png",
      title: "WELCOME!",
      supTitle:
          "Makeup has the power to transform your \nmood and empowers you to be a more \nconfident person.",
    ),
    _Collection(
      img: "assets/images/on_boarding2.png",
      title: "SEARCH & PICK",
      supTitle:
          "We have dedicated set of products \nand routines hand picked for every skin type.",
    ),
    _Collection(
      img: "assets/images/ring.png",
      title: "PUSH NOTIFICATIONS ",
      supTitle: "Allow notifications for new makeup & \ncosmetics offers.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: currentPage == list.length - 1
                  ? null
                  : TextButton(
                      onPressed: () {
                        goTo(page: const LogInView());
                      },
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff434C6D),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 79),
            Align(
              alignment: AlignmentDirectional.center,
              child: Image.asset(
                list[currentPage].img,
                height: 259.6,
                width: 283.68,
              ),
            ),
            const SizedBox(height: 28),
            Text(
              list[currentPage].title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff434C6D),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              list[currentPage].supTitle,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff434C6D),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            currentPage == list.length - 1
                ? SizedBox(
                    height: 65,
                    width: 268,
                    child: FilledButton(
                      onPressed: () {
                        goTo(page: const LogInView());
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xff434C6D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60),
                        ),
                      ),
                      child: const Text(
                        "let’s start!",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : FloatingActionButton(
                    onPressed: () {
                      if (currentPage == list.length - 1) {
                        goTo(page: const LogInView());
                      } else {
                        setState(() {
                          currentPage++;
                        });
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: const Color(0xff434C6D),
                    child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  ),
          ],
        ),
      ),
    );
  }
}

class _Collection {
  String img, title, supTitle;

  _Collection({required this.img, required this.title, required this.supTitle});
}
