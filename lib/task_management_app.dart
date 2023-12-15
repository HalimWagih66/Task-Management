import 'package:flutter/material.dart';
import 'package:task_management/core/style/theme/theme.dart';

import 'features/auth/continue_account/view/continue_account_view.dart';
import 'features/auth/continue_account_with_email_view/view/continue_with_email_view.dart';

class TaskManagementApp extends StatelessWidget {
  const TaskManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Task Management",
      debugShowCheckedModeBanner: false,
      routes: {
        ContinueAccountView.routeName:(context) => const ContinueAccountView(),
        ContinueAccountWithEmailView.routeName:(context)=> const ContinueAccountWithEmailView()

      },
      initialRoute:ContinueAccountView.routeName,
      theme:ThemeApp.lightTheme
    );
  }
}
