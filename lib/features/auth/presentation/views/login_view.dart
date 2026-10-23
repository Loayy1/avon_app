import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/logic/helper_methods.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_states.dart';
import 'forget_password_view.dart';
import 'sign_in_view.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

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
                            const SizedBox(height: 48),
                            Image.asset(
                              "assets/images/login_img.png",
                              height: 227,
                              width: 284,
                            ),
                            const SizedBox(height: 45),
                            const Text(
                              "Login Now",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff434C6D),
                              ),
                            ),
                            const SizedBox(height: 14),
                            const Text(
                              "Please enter the details below to continue",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff8E8EA9),
                              ),
                            ),
                            const SizedBox(height: 41),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0x665A6690),
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
                                        dropdownColor: const Color(0xffD9D9D9),
                                        value: cubit.phoneCode,
                                        hint: const Text("code"),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 19,
                                        ),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff434C6D),
                                        ),
                                        items: const [
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
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Color(0xff767676),
                                          size: 17,
                                        ),
                                        underline: const SizedBox(),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 6),
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
                                        cursorColor: const Color(0xff434C6D),
                                        style: const TextStyle(
                                          color: Color(0xff434C6D),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        decoration: InputDecoration(
                                          errorText: cubit.errorMsg,
                                          labelText: "Phone Number",
                                          labelStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff8E8EA9),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide:
                                                state is LogInFailedState
                                                ? const BorderSide(color: Colors.red)
                                                : const BorderSide(
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
                            const SizedBox(height: 8),
                            BlocBuilder(
                              bloc: cubit,
                              buildWhen: (previous, current) =>
                                  current is! LogInCodeUpdateState,
                              builder: (context, state) {
                                print("loay TextFormField2");
                                return TextFormField(
                                  controller: cubit.passwordController,
                                  obscureText: cubit.isObscure,
                                  cursorColor: const Color(0xff434C6D),
                                  style: const TextStyle(
                                    color: Color(0xff434C6D),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    errorText: cubit.errorMsg,
                                    hintText: "Your Password",
                                    hintStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff8E8EA9),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: state is LogInFailedState
                                          ? const BorderSide(color: Colors.red)
                                          : const BorderSide(
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
                            const SizedBox(height: 8),
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: TextButton(
                                onPressed: () {
                                  goTo(
                                    page: const ForgetPasswordView(),
                                    keepHistory: true,
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: const Color(
                                    0xffD75D72,
                                  ).withValues(alpha: .4),
                                ),
                                child: const Text(
                                  "Forget Password?",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffD75D72),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 43),
                            BlocBuilder(
                              bloc: cubit,
                              buildWhen: (previous, current) =>
                                  current is! LogInTogglePasswordState,
                              builder: (context, state) {
                                return FilledButton.icon(
                                  icon: state is LogInLoadingState
                                      ? const SizedBox(
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
                                    backgroundColor: const Color(0xffD75D72),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                      horizontal: 97,
                                    ),
                                    disabledBackgroundColor: const Color(
                                      0xffD75D72,
                                    ).withValues(alpha: .4),
                                  ),
                                  label: const Text("Login"),
                                );
                              },
                            ),
                            const SizedBox(height: 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don’t have an account?",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    goTo(page: const SignInView(), keepHistory: true);
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: const Color(
                                      0xffD75D72,
                                    ).withValues(alpha: .4),
                                  ),
                                  child: const Text(
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
