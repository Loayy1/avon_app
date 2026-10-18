import 'package:cosmetics_app/views/auth/create_password/view.dart';
import 'package:cosmetics_app/views/auth/forget_password.dart';
import 'package:cosmetics_app/views/auth/log_in/view.dart';
import 'package:cosmetics_app/views/auth/on_boarding.dart';
import 'package:cosmetics_app/views/auth/sign_in.dart';
import 'package:cosmetics_app/views/auth/splash.dart';
import 'package:cosmetics_app/views/auth/verify.dart';
import 'package:cosmetics_app/views/pages/cart/view.dart';
import 'package:cosmetics_app/views/pages/cart/checkout.dart';
import 'package:cosmetics_app/views/pages/categories/view.dart';
import 'package:cosmetics_app/views/pages/home/view.dart';
import 'package:cosmetics_app/views/pages/profile/view.dart';
import 'package:cosmetics_app/views/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/logic/helper_methods.dart';

void main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navKey,
      home:LogInView(),
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xffD9D9D9),
        appBarTheme: AppBarThemeData(
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        inputDecorationTheme: InputDecorationThemeData(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0x665A6690)),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0x665A6690)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0x665A6690)),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0x665A6690)),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(backgroundColor: Color(0x665A6690)),
        ),
      ),
    ),
  );
}