import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/logic/helper_methods.dart';
import '../../features/auth/presentation/cubits/register_cubit.dart';
import '../../features/auth/presentation/cubits/register_states.dart';
import 'log_in/view.dart';
import 'verify.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Builder(
        builder: (context) {
          final cubit = BlocProvider.of<RegisterCubit>(context);
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: SingleChildScrollView(
                  child: BlocConsumer<RegisterCubit, RegisterStates>(
                    listener: (context, state) {
                      if (state is RegisterSuccessState) {
                        goTo(
                          page: VerifyView(
                            fromSignIn: true,
                            phone: cubit.phoneController.text.trim(),
                            phoneCode: cubit.phoneCode,
                          ),
                          keepHistory: true,
                        );
                      } else if (state is RegisterFailedState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Form(
                        onChanged: cubit.updateForm,
                        child: Column(
                          children: [
                            const SizedBox(height: 40),
                            Image.asset(
                              "assets/images/logo.png",
                              height: 62,
                              width: 67,
                            ),
                            const SizedBox(height: 40),
                            const Text(
                              "Create Account",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff434C6D),
                              ),
                            ),
                            const SizedBox(height: 50),
                            TextFormField(
                              controller: cubit.nameController,
                              cursorColor: const Color(0xff434C6D),
                              decoration: const InputDecoration(
                                labelText: "Your Name",
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff8E8EA9),
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff434C6D),
                              ),
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: cubit.emailController,
                              cursorColor: const Color(0xff434C6D),
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: "Email",
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff8E8EA9),
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff434C6D),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0x665A6690),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: DropdownButton<String>(
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
                                      DropdownMenuItem(
                                        value: "+20",
                                        child: Text("+20"),
                                      ),
                                      DropdownMenuItem(
                                        value: "+212",
                                        child: Text("+212"),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      if (value != null) {
                                        cubit.updateCode(value);
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(8),
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Color(0xff767676),
                                      size: 17,
                                    ),
                                    underline: const SizedBox(),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: TextFormField(
                                    controller: cubit.phoneController,
                                    keyboardType: TextInputType.phone,
                                    cursorColor: const Color(0xff434C6D),
                                    style: const TextStyle(
                                      color: Color(0xff434C6D),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    decoration: const InputDecoration(
                                      labelText: "Phone Number",
                                      labelStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff8E8EA9),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              obscureText: cubit.isOccurred,
                              controller: cubit.passwordController,
                              decoration: InputDecoration(
                                hintText: "Create your password",
                                hintStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff8E8EA9),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: cubit.togglePassword,
                                  icon: SvgPicture.asset(
                                    "assets/icons/visibility_${cubit.isOccurred ? "off" : "on"}.svg",
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              obscureText: cubit.isOccurredInConfirm,
                              controller: cubit.confirmPasswordController,
                              decoration: InputDecoration(
                                hintText: "Confirm password",
                                hintStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff8E8EA9),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: cubit.toggleConfirmPassword,
                                  icon: SvgPicture.asset(
                                    "assets/icons/visibility_${cubit.isOccurredInConfirm ? "off" : "on"}.svg",
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                            FilledButton(
                              onPressed: (state is RegisterLoadingState ||
                                      cubit.nameController.text.isEmpty ||
                                      cubit.emailController.text.isEmpty ||
                                      cubit.phoneController.text.isEmpty ||
                                      cubit.passwordController.text.isEmpty ||
                                      cubit.confirmPasswordController.text.isEmpty)
                                  ? null
                                  : () => cubit.register(),
                              style: FilledButton.styleFrom(
                                disabledBackgroundColor:
                                    const Color(0xffD75D72).withValues(alpha: .4),
                                backgroundColor: const Color(0xffD75D72),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 117,
                                ),
                              ),
                              child: state is RegisterLoadingState
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      "Next",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 45),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Have an account?",
                                  style: TextStyle(
                                    color: Color(0xff434C6D),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => goTo(page: LogInView()),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Color(0xffD75D72),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
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
