import 'package:cosmetics_app/core/logic/helper_methods.dart';
import 'package:cosmetics_app/views/auth/log_in/cubit.dart';
import 'package:cosmetics_app/views/auth/log_in/states.dart';
import 'package:cosmetics_app/views/auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../forget_password.dart';

class LogInView extends StatefulWidget {
  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  @override
  Widget build(BuildContext context) {
    print("loay build");
    return BlocProvider(
      create: (context) => LogInCubit(),
      child: Builder(
        builder: (ctx) {
          print("loay BlocProvider");
          final cubit = BlocProvider.of<LogInCubit>(ctx);
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: SingleChildScrollView(
                  child: BlocBuilder(
                    bloc: cubit,
                    buildWhen: (previous, current) =>
                        current is LogInFormUpdateState,
                    builder: (context, state) {
                      print("loay Form");
                      return Form(
                        onChanged: cubit.formUpdate,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 48),
                            Image.asset(
                              "assets/images/login_img.png",
                              height: 227,
                              width: 284,
                            ),
                            SizedBox(height: 45),
                            Text(
                              "Login Now",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff434C6D),
                              ),
                            ),
                            SizedBox(height: 14),
                            Text(
                              "Please enter the details below to continue",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff8E8EA9),
                              ),
                            ),
                            SizedBox(height: 41),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0x665A6690),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: BlocBuilder(
                                    bloc: cubit,
                                    buildWhen: (previous, current) =>
                                        current is LogInCodeUpdateState,
                                    builder: (context, state) {
                                      print("loay code");
                                      return DropdownButton(
                                        dropdownColor: Color(0xffD9D9D9),
                                        value: cubit.phoneCode,
                                        hint: Text("code"),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 19,
                                        ),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff434C6D),
                                        ),
                                        items: [
                                          DropdownMenuItem<String>(
                                            value: "+20",
                                            child: Text("+20"),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "+212",
                                            child: Text("+212"),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          cubit.codeUpdate(value!);
                                        },
                                        borderRadius: BorderRadius.circular(8),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Color(0xff767676),
                                          size: 17,
                                        ),
                                        underline: SizedBox(),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: 6),
                                Expanded(
                                  child: BlocBuilder(
                                    bloc: cubit,
                                    buildWhen: (previous, current) =>
                                        current is! LogInCodeUpdateState,
                                    builder: (context, state) {
                                      print("loay TextFormField");
                                      return TextFormField(
                                        controller: cubit.phoneController,
                                        keyboardType: TextInputType.phone,
                                        cursorColor: Color(0xff434C6D),
                                        style: TextStyle(
                                          color: Color(0xff434C6D),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        decoration: InputDecoration(
                                          errorText: cubit.errorMsg,
                                          labelText: "Phone Number",
                                          labelStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff8E8EA9),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide:
                                                state is LogInFailedState
                                                ? BorderSide(color: Colors.red)
                                                : BorderSide(
                                                    color: Color(0x665A6690),
                                                  ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            BlocBuilder(
                              bloc: cubit,
                              buildWhen: (previous, current) =>
                                  current is! LogInCodeUpdateState,
                              builder: (context, state) {
                                print("loay TextFormField2");
                                return TextFormField(
                                  controller: cubit.passwordController,
                                  obscureText: cubit.isObscure,
                                  cursorColor: Color(0xff434C6D),
                                  style: TextStyle(
                                    color: Color(0xff434C6D),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    errorText: cubit.errorMsg,
                                    hintText: "Your Password",
                                    hintStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff8E8EA9),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: state is LogInFailedState
                                          ? BorderSide(color: Colors.red)
                                          : BorderSide(
                                              color: Color(0x665A6690),
                                            ),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: cubit.togglePassword,
                                      icon: SvgPicture.asset(
                                        "assets/icons/visibility_${cubit.isObscure ? "off" : "on"}.svg",
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 8),
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: TextButton(
                                onPressed: () {
                                  goTo(
                                    page: ForgetPasswordView(),
                                    keepHistory: true,
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Color(
                                    0xffD75D72,
                                  ).withValues(alpha: .4),
                                ),
                                child: Text(
                                  "Forget Password?",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffD75D72),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 43),
                            BlocBuilder(
                              bloc: cubit,
                              buildWhen: (previous, current) =>
                                  current is! LogInTogglePasswordState,
                              builder: (context, state) {
                                return FilledButton.icon(
                                  icon: state is LogInLoadingState
                                      ? SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : null,
                                  onPressed:
                                      cubit.phoneController.text.isEmpty ||
                                          cubit
                                              .passwordController
                                              .text
                                              .isEmpty ||
                                          cubit.phoneCode == null
                                      ? null
                                      : () {
                                          print(
                                            "Phone: ${cubit.phoneController.text}",
                                          );
                                          print(
                                            "Password: ${cubit.passwordController.text}",
                                          );
                                          state is LogInLoadingState
                                              ? null
                                              : cubit.logIn();
                                        },
                                  style: FilledButton.styleFrom(
                                    backgroundColor: Color(0xffD75D72),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 20,
                                      horizontal: 97,
                                    ),
                                    disabledBackgroundColor: Color(
                                      0xffD75D72,
                                    ).withValues(alpha: .4),
                                  ),
                                  label: Text("Login"),
                                );
                              },
                            ),
                            SizedBox(height: 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don’t have an account?",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    goTo(page: SignInView(), keepHistory: true);
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Color(
                                      0xffD75D72,
                                    ).withValues(alpha: .4),
                                  ),
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffD75D72),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
