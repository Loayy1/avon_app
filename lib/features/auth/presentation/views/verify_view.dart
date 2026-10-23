import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/logic/helper_methods.dart';
import '../../../main/presentation/views/main_view.dart';
import '../cubit/verify_cubit.dart';
import '../cubit/verify_states.dart';
import 'create_password_view.dart';
import 'forget_password_view.dart';

class VerifyView extends StatelessWidget {
  final bool fromSignIn;
  final String? phone;
  final String? phoneCode;

  const VerifyView({
    super.key,
    required this.fromSignIn,
    this.phone,
    this.phoneCode,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyCubit(),
      child: Builder(
        builder: (context) {
          final cubit = BlocProvider.of<VerifyCubit>(context);
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(13),
                  child: BlocConsumer<VerifyCubit, VerifyStates>(
                    listener: (context, state) {
                      if (state is VerifySuccessState) {
                        if (fromSignIn) {
                          _showSuccessDialog(context);
                        } else {
                          goTo(
                            page: CreatePasswordView(
                              phone: phone,
                              phonecode: phoneCode,
                            ),
                          );
                        }
                      } else if (state is VerifyResendSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("OTP Code resent successfully"),
                            backgroundColor: Color(0xff434C6D),
                          ),
                        );
                      } else if (state is VerifyFailedState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          if (!fromSignIn)
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: IconButton(
                                onPressed: () => goTo(page: const ForgetPasswordView()),
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
                          const SizedBox(height: 40),
                          Image.asset(
                            "assets/images/logo.png",
                            height: 62,
                            width: 67,
                          ),
                          const SizedBox(height: 40),
                          const Text(
                            "Verify Code",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff434C6D),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Text(
                            "We just sent a 4-digit verification code to \n${phoneCode ?? "+20"} ${phone ?? ''}. Enter the code in the box \nbelow to continue.",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff8E8EA9),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(4, (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xffD75D72),
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: TextFormField(
                                    controller: cubit.codeControllers[index],
                                    focusNode: cubit.focusNodes[index],
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    cursorColor: const Color(0xff434C6D),
                                    maxLength: 1,
                                    onChanged: (value) {
                                      cubit.onCodeChanged();
                                      if (value.isNotEmpty && index < 3) {
                                        FocusScope.of(context).requestFocus(
                                          cubit.focusNodes[index + 1],
                                        );
                                      } else if (value.isEmpty && index > 0) {
                                        FocusScope.of(context).requestFocus(
                                          cubit.focusNodes[index - 1],
                                        );
                                      }
                                    },
                                    decoration: const InputDecoration(
                                      counterText: "",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.zero,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 35),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Didn’t receive a code? ",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff434C6D),
                                ),
                              ),
                              TextButton(
                                onPressed: state is VerifyResendLoadingState
                                    ? null
                                    : () {
                                        cubit.resendOtp(
                                          countryCode: phoneCode ?? "+20",
                                          phoneNumber: phone ?? "",
                                        );
                                      },
                                child: state is VerifyResendLoadingState
                                    ? const SizedBox(
                                        height: 14,
                                        width: 14,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text(
                                        "Resend",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xffD75D72),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 45),
                          FilledButton(
                            onPressed: (state is VerifyLoadingState ||
                                    cubit.otpCode.length < 4)
                                ? null
                                : () {
                                    cubit.verifyOtp(
                                      countryCode: phoneCode ?? "+20",
                                      phoneNumber: phone ?? "",
                                    );
                                  },
                            style: FilledButton.styleFrom(
                              disabledBackgroundColor:
                                  const Color(0xffD75D72).withValues(alpha: .4),
                              backgroundColor: const Color(0xffD75D72),
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 115,
                              ),
                            ),
                            child: state is VerifyLoadingState
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    "Done",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ],
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

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/images/done_verify.png"),
              const SizedBox(height: 26),
              const Text(
                "Account Activated!",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff434C6D),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Congratulations! Your account \nhas been successfully activated",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff8E8EA9),
                ),
              ),
              const SizedBox(height: 23),
              FilledButton(
                onPressed: () => goTo(page: const ViewPage()),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xffD75D72),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 70,
                  ),
                ),
                child: const Text(
                  "Go to home",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
