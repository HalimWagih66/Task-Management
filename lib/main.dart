import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:task_management/core/const/constant.dart';
import 'package:task_management/core/model/user_info_model.dart';
import 'package:task_management/features/edit_profile/view%20model/replace_phone_number_provider.dart';
import 'package:task_management/provider/user_information_provider.dart';
import 'package:task_management/task_management_app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(UserInformationModelAdapter());
  await Hive.openBox<UserInformationModel>(kUserInformationBox);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserInformationProvider()),
        ChangeNotifierProvider(create: (context) => ReplacePhoneNumberProvider())
      ],
      child: const TaskManagementApp(),
    ),
  );
}
