import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widget/dialogs/hide_dialog.dart';
import '../widget/dialogs/show_loading.dart';
import '../widget/dialogs/show_message.dart';
import '../widget/dialogs/show_message_awesome_dialog.dart';
import 'base_navigator.dart';
import 'base_view_model.dart';

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  late VM viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
    viewModel.navigator = this;
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  void pushScreenWithWidgetAndRemoveUntil(Widget widget,bool saveRoutes){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget,), (route) => saveRoutes);
  }
  @override
  Future<void> showToastMessage(String message)async=>await Fluttertoast.showToast(msg: message,textColor: Colors.white,backgroundColor: Colors.green,fontSize: 19);
  VM initViewModel();
  @override
  void showLoading({String showMessage = "Loading"}) {
    showLoadingDialog(context);
  }
  @override
  void showMessageSnackPar({required String message}){
    showMessageWithSnackPar(message: message,context: context);
  }

  @override
  void showMessageAwesome(
      {required String message,
      required DialogType dialogType,
      String? title,
      Function? nigAction,
      String? nigActionName,
      Function? posAction,
      String? posActionName}) {
    showMessageWithAwesomeDialog(
        context: context,
        message: message,
        dialogType: dialogType,
        title: title,
        nigAction: nigAction,
        nigActionName: nigActionName,
        posAction: posAction,
        posActionName: posActionName
    );
  }


  @override
  void navigatorPop() {
    hideDialog(context);
  }
  @override
  void pushScreenAndRemoveUntil({required String routeName, Object? arg}){
    Navigator.pushNamedAndRemoveUntil(context, routeName,arguments: arg,(route) => false);
  }

  @override
  void pushScreen({required String routeName, Object? arg}){
    Navigator.pushNamed(context, routeName,arguments: arg);
  }
}
