import 'package:cosmetics_app/core/logic/helper_methods.dart';
import 'package:cosmetics_app/views/auth/create_password/states.dart';
import 'package:cosmetics_app/views/auth/log_in/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'cubit.dart';

class CreatePasswordView extends StatefulWidget {
  final String? phone;
  final String? phonecode;

  const CreatePasswordView({super.key, this.phone, this.phonecode});

  @override
  State<CreatePasswordView> createState() => _CreatePasswordViewState();
}

class _CreatePasswordViewState extends State<CreatePasswordView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePasswordCubit(),
      child: Builder(
        builder: (ctx) {
          final cubit = BlocProvider.of<CreatePasswordCubit>(ctx);
          return BlocListener(bloc: cubit,
            listener: (context, state) {
              if (state is CreatePasswordSuccessState) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset("assets/images/done_verify.png"),
                          SizedBox(height: 26),
                          Text(
                            "Password Created!",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff434C6D),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Congratulations! Your password \nhas been successfully created",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff8E8EA9),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 26),
                          TextButton(
                            onPressed: () {
                              goTo(page: LogInView());
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 54,
                              ),
                              backgroundColor: Color(0xffD75D72),
                              foregroundColor: Colors.white,
                            ),
                            child: Text("Return to login"),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
            child: Scaffold(
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(13),
                    child: BlocBuilder(bloc: cubit,
                      builder: (context, state) {
                        return Form(
                          onChanged:cubit.formUpdate,
                          child: Column(
                            children: [
                              SizedBox(height: 40),
                              Image.asset(
                                "assets/images/logo.png",
                                height: 62,
                                width: 67,
                              ),
                              SizedBox(height: 40),
                              Text(
                                "Create Password",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff434C6D),
                                ),
                              ),
                              SizedBox(height: 40),
                              Text(
                                "The password should have at least\n6 characters.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff8E8EA9),
                                ),
                              ),
                              SizedBox(height: 80),
                              BlocBuilder(bloc: cubit,buildWhen: (previous, current) => current is CreatePasswordToggleState,
                                builder: (context, state) {
                                  return TextFormField(
                                    controller: cubit.passwordController,
                                    obscureText: cubit.isObscure,
                                    decoration: InputDecoration(
                                      hintText: "New password",
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff8E8EA9),
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: cubit.setPasswordObscure,
                                        icon: SvgPicture.asset(
                                          "assets/icons/visibility_${cubit.isObscure ? "off" : "on"}.svg",
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 16),
                              BlocBuilder(bloc: cubit,
                                buildWhen: (previous, current) => current is CreatePasswordToggleConfirmState,
                                builder: (context, state) {
                                  return TextFormField(
                                    controller: cubit.confirmPasswordController,
                                    obscureText: cubit.confirmIsObscure,
                                    decoration: InputDecoration(
                                      hintText: "Confirm password",
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff8E8EA9),
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: cubit.confirmObscure,
                                        icon: SvgPicture.asset(
                                          "assets/icons/visibility_${cubit.confirmIsObscure ? "off" : "on"}.svg",
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 72),
                              TextButton(
                                onPressed:
                                cubit.passwordController.text.isEmpty ||
                                    cubit.confirmPasswordController.text.isEmpty &&
                                    cubit.passwordController.text !=
                                        cubit.confirmPasswordController.text
                                    ? null
                                    : () {
                                  cubit.resetPassword(
                                    phone: widget.phone ?? '',
                                    phoneCode: widget.phonecode ?? '',
                                  );
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 21,
                                    horizontal: 88,
                                  ),
                                  backgroundColor: Color(0xffD75D72),
                                  foregroundColor: Colors.white,
                                  disabledBackgroundColor: Colors.grey,
                                ),
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
