import 'package:flutter/material.dart';
import 'package:task_management/core/style/theme/theme.dart';

import 'features/auth/continue_account/view/continue_account_view.dart';

class TaskManagementApp extends StatelessWidget {
  const TaskManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Task Management",
      debugShowCheckedModeBanner: false,
      routes: {
        ContinueAccountView.routeName:(context) => const ContinueAccountView()
      },
      initialRoute:ContinueAccountView.routeName,
      theme:ThemeApp.lightTheme
    );
  }
}
