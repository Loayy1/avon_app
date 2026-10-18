import 'package:cosmetics_app/views/auth/log_in/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/logic/dio_helper.dart';
import 'core/logic/helper_methods.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.loadToken();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navKey,
      home: LogInView(),
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