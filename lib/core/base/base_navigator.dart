import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
abstract class BaseNavigator {
  void showLoading({String showMessage = "Loading"});
  void showMessageSnackPar({required String message});
  void showMessageAwesome({required String message,required DialogType dialogType,String? title,Function? nigAction,String? nigActionName,Function? posAction,String? posActionName});
  void navigatorPop();
  void pushScreenAndRemoveUntil({required String routeName, Object? arg});
  void pushScreen({required String routeName, Object? arg});
  Future<void> showToastMessage(String message);
  void pushScreenWithWidgetAndRemoveUntil(Widget widget,bool saveRoutes);
  void pushScreenWithWidget(Widget widget);
}

