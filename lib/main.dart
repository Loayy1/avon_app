import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/logic/dio_helper.dart';
import 'core/logic/helper_methods.dart';
import 'features/auth/presentation/views/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.loadToken();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navKey,
      home: const SplashView(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffD9D9D9),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0x665A6690)),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0x665A6690)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0x665A6690)),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0x665A6690)),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(backgroundColor: const Color(0x665A6690)),
        ),
      ),
    ),
  );
}
