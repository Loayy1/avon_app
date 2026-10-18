import 'package:cosmetics_app/core/logic/dio_helper.dart';
import 'package:cosmetics_app/core/logic/helper_methods.dart';
import 'package:cosmetics_app/views/auth/sign_in.dart';
import 'package:cosmetics_app/views/pages/home/view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../view.dart';
import 'create_password/view.dart';
import 'forget_password.dart';

class VerifyView extends StatefulWidget {
  final bool fromSignIn;
  final phone;
  final phoneCode;

  const VerifyView({super.key, required this.fromSignIn, this.phone, this.phoneCode});

  @override
  State<VerifyView> createState() => _VerifyViewState();
}

class _VerifyViewState extends State<VerifyView> {
  final List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  final List<TextEditingController> codeController = List.generate(
    4,
    (index) => TextEditingController(),
  );

  void verifyCode() async {
    final code = codeController.map((e) =>e.text ).join();

    final resp = await DioHelper.sendData(
      "/api/Auth/verify-otp",
      data: {"countryCode": widget.phoneCode, "phoneNumber": widget.phone, "otpCode": code},
    );
    print("Data : ${resp.data}");
    if (resp.isSuccess) {
      if (widget.fromSignIn) {
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
                    "Account Activated!",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff434C6D),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Congratulations! Your account \nhas been successfully activated",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff8E8EA9),
                    ),
                  ),
                  SizedBox(height: 23),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (widget.fromSignIn == true) {
                          goTo(page: ViewPage());
                        } else {
                          goTo(page: CreatePasswordView(phone: widget.phone,phonecode: widget.phoneCode,));
                        }
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xffD75D72),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 91,
                      ),
                    ),
                    child: Text(
                      widget.fromSignIn ? "Go to home" : "create password",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      } else {
        goTo(page: CreatePasswordView(phone: widget.phone,phonecode: widget.phoneCode));
      }
    }
  }
  
  void reSendCode()async{
    final resp=await DioHelper.sendData("/api/Auth/resend-otp",data: {
      "countryCode": "+20",
      "phoneNumber": widget.phone
    });
    print("Data: ${resp.data}");
  }

  @override
  void dispose() {
    for (var controller in codeController) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Form(
              onChanged: () {
                setState(() {});
              },
              child: Column(
                children: [
                  ?widget.fromSignIn
                      ? null
                      : Align(
                          alignment: AlignmentDirectional.topStart,
                          child: IconButton(
                            onPressed: () {
                              goTo(page: ForgetPasswordView());
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 22,
                              color: Color(0xff101010),
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: Color(0x0D101010),
                              fixedSize: Size(22, 22),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                  SizedBox(height: 40),
                  Image.asset("assets/images/logo.png", height: 62, width: 67),
                  SizedBox(height: 40),
                  Text(
                    "Verify Code",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff434C6D),
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    "We just sent a 4-digit verification code to \n+20 1022658997 Enter the code in the box \nbelow to continue.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff8E8EA9),
                    ),
                  ),
                  SizedBox(height: 40),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Color(0xffD75D72).withValues(alpha: .4),
                      ),
                      child: Text(
                        "Edit the number",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffD75D72),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffD75D72),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: codeController[index],
                            focusNode: focusNodes[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            cursorColor: Color(0x38101010),
                            maxLength: 1,
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 3) {
                                FocusScope.of(
                                  context,
                                ).requestFocus(focusNodes[index + 1]);
                              }
                            },
                            decoration: InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 43),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Didn’t receive a code? ",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff434C6D),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          reSendCode();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Color(
                            0xffD75D72,
                          ).withValues(alpha: .1),
                        ),
                        child: Text(
                          "Resend",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0x8AD75D72),
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "0:36",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff8E8EA9),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 113),
                  TextButton(
                    onPressed:
                        codeController[0].text.isEmpty ||
                            codeController[1].text.isEmpty ||
                            codeController[2].text.isEmpty ||
                            codeController[3].text.isEmpty
                        ? null
                        : () {
                            verifyCode();
                          },
                    style: TextButton.styleFrom(
                      disabledBackgroundColor: Colors.grey,
                      backgroundColor: Color(0xffD75D72),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        vertical: 21,
                        horizontal: 115,
                      ),
                    ),
                    child: Text("Done", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
