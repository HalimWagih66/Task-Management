import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:task_management/features/auth/sign%20up/view/widget/pin_theme_otp.dart';

import '../../../../../provider/user_information_provider.dart';
import '../../view model/sign_up_view_model.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key, required this.pinController});

  final TextEditingController pinController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        Text(
          "Verify Your",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          "Phone Number",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: Text(
            "Enter Your  OTP code here",
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        Pinput(
          length: 6,
          controller: pinController,
          focusedPinTheme: pinThemeOtp(
              context: context,
              colorBorderPin: Colors.blue,
              colorTextPin: Colors.blue),
          errorPinTheme: pinThemeOtp(
              context: context,
              colorBorderPin: Colors.blue,
              colorTextPin: Colors.blue),
          defaultPinTheme: pinThemeOtp(
              context: context,
              colorBorderPin: Colors.transparent,
              colorTextPin: Colors.black),
          onCompleted: (value) async {
            await onCompleted(context, value);
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.06,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'OTP not received?',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            GestureDetector(
              child: Text(' RESEND',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.blue)),
              onTap: () async {
                await Provider.of<SignUpViewModel>(context,listen: false).verifyPhoneNumber(userCredential: Provider.of<SignUpViewModel>(context,listen: false).userCredential!);
                pinController.text = "";
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Text('Edit ',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.blue)),
              onTap: () async {
                Provider.of<SignUpViewModel>(context, listen: false)
                    .navigator
                    .controlPageViewBuilder(4);
                pinController.text = "";
              },
            ),
            Text(
              'Your Phone Number',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ],
    );
  }

  Future<void> onCompleted(BuildContext context, String smsCode) async {
    await Provider.of<SignUpViewModel>(context,listen: false).verifySmsCode(smsCode);
  }
}
