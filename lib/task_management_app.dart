import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management/core/style/theme/theme.dart';
import 'package:task_management/features/auth/login/view/login_view.dart';
import 'package:task_management/features/auth/sign%20up/view/sign_up_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_management/features/home%20layout/view/widget/home_view.dart';
import 'features/auth/continue_account/view/continue_account_view.dart';
import 'features/auth/continue_account_with_email_view/view/continue_with_email_view.dart';
import 'features/home layout/view/home_layout_view.dart';
import 'onboarding/view/on_boarding_view.dart';

class TaskManagementApp extends StatelessWidget {
  const TaskManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Task Management",
      debugShowCheckedModeBanner: false,
      routes: {
        HomeLayout.routeName:(context) => const HomeLayout(),
        ContinueAccountView.routeName:(context) => const ContinueAccountView(),
        ContinueAccountWithEmailView.routeName:(context)=> const ContinueAccountWithEmailView(),
        SignUpView.routeName:(context) => const SignUpView(),
        LoginView.routeName:(context) => const LoginView(),
        OnBoardingView.routeName:(context) => const OnBoardingView()
      },
      initialRoute:FirebaseAuth.instance.currentUser ==null?ContinueAccountWithEmailView.routeName:HomeLayout.routeName,
      theme:ThemeApp.lightTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // Spanish
      ],
    );
  }
}
