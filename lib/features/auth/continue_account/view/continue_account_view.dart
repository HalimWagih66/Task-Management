import 'package:flutter/material.dart';
import 'package:task_management/features/auth/continue_account/view/widgets/button_continue_account.dart';
import 'package:task_management/features/auth/continue_account/view/widgets/custom_line.dart';
import '../../../../core/base/base_state.dart';
import '../../../../core/style/colors/application_color.dart';
import '../../continue_account_with_email_view/view/continue_with_email_view.dart';
import '../navigator/continue_account_navigator.dart';
import '../view model/continue_account_view_model.dart';
class ContinueAccountView extends StatefulWidget {
  const ContinueAccountView({super.key});

  static const routeName = "ContinueAccount";

  @override
  State<ContinueAccountView> createState() => _ContinueAccountViewState();
}

class _ContinueAccountViewState extends BaseState<ContinueAccountView, ContinueAccountViewModel>
    implements ContinueAccountNavigator {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text("Set up your profile",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onPressed: () {
                    Navigator.pushNamed(context, ContinueAccountWithEmailView.routeName);
                  },
                  child: Text(
                    "Continue with email",
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(color: Colors.white),
                  )),
              const CustomLine(),
              ButtonContinueAccount(
                  onLongPress: () async {
                  },
                  onPressed: () async {
                  },
                  image: "assets/images/auth/continue account/google_icon.png",
                  text: "Continue with Google"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: ButtonContinueAccount(
                    onLongPress: () async {},
                    onPressed: () async {
                    },
                    icon: Icons.facebook,
                    text: "Continue with Facebook"),
              ),
              ButtonContinueAccount(
                  onLongPress: () async {

                  },
                  onPressed: () async {},
                  image: "assets/images/auth/continue account/Twitter-icon.png",
                  text: "Continue with Twitter"),
            ],
          ),
        ));
  }

  @override
  ContinueAccountViewModel initViewModel() {
    return ContinueAccountViewModel();
  }



}
