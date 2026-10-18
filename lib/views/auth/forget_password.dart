import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logic/helper_methods.dart';
import '../../features/auth/presentation/cubits/forgot_password_cubit.dart';
import '../../features/auth/presentation/cubits/forgot_password_states.dart';
import 'log_in/view.dart';
import 'verify.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(),
      child: Builder(
        builder: (context) {
          final cubit = BlocProvider.of<ForgotPasswordCubit>(context);
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(13),
                  child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordStates>(
                    listener: (context, state) {
                      if (state is ForgotPasswordSuccessState) {
                        goTo(
                          page: VerifyView(
                            fromSignIn: false,
                            phone: cubit.phoneController.text.trim(),
                            phoneCode: cubit.phoneCode,
                          ),
                          keepHistory: true,
                        );
                      } else if (state is ForgotPasswordFailedState) {
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
                            const SizedBox(height: 16),
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: IconButton(
                                onPressed: () => goTo(page: LogInView()),
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  size: 22,
                                  color: Color(0xff101010),
                                ),
                                style: IconButton.styleFrom(
                                  backgroundColor: const Color(0x0D101010),
                                  fixedSize: const Size(22, 22),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                              ),
                            ),
                            Image.asset(
                              "assets/images/logo.png",
                              height: 62,
                              width: 67,
                            ),
                            const SizedBox(height: 40),
                            const Text(
                              "Forget Password",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff434C6D),
                              ),
                            ),
                            const SizedBox(height: 40),
                            const Text(
                              "Please enter your phone number below \nto recover your password.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff8E8EA9),
                              ),
                            ),
                            const SizedBox(height: 45),
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
                            const SizedBox(height: 56),
                            FilledButton(
                              onPressed: (state is ForgotPasswordLoadingState ||
                                      cubit.phoneController.text.isEmpty)
                                  ? null
                                  : () => cubit.forgotPassword(),
                              style: FilledButton.styleFrom(
                                disabledBackgroundColor:
                                    const Color(0xffD75D72).withValues(alpha: .4),
                                backgroundColor: const Color(0xffD75D72),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 117,
                                ),
                              ),
                              child: state is ForgotPasswordLoadingState
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
