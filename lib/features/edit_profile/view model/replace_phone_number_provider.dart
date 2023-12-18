import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:task_management/core/model/user_info_model.dart';
import 'package:task_management/core/widget/dialogs/show_loading.dart';
import 'package:task_management/core/widget/dialogs/show_message_awesome_dialog.dart';
import 'package:task_management/features/auth/Dao/users_dao.dart';
import 'package:task_management/provider/user_information_provider.dart';

class ReplacePhoneNumberProvider extends ChangeNotifier{
  String? verificationId;
  bool isPhoneReplace = false;
  String? phoneNumber;
  String? fullName;
  bool isPhoneReplaced = false;
  Future<void> verifySmsCode(String smsCode,BuildContext context) async {
    showLoadingDialog(context);
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId!, smsCode: smsCode
      );
      isPhoneReplace = false;
      isPhoneReplaced = true;
      UserInformationModel userInformationModel = Provider.of<UserInformationProvider>(context,listen: false).userInformationModel;
      userInformationModel.phoneNumber = phoneNumber;
      UsersDao.createUser(userInformationModel);
      Fluttertoast.showToast(msg: "Phone number changed successfully",gravity:ToastGravity.BOTTOM ,timeInSecForIosWeb:4);
      Navigator.pop(context);
      Navigator.pop(context);
      print("verifySmsCode");
    } on FirebaseAuthException catch (e) {
      await caseEventException(e.message ?? e.code,context);
    }catch (e){
      await caseEventException(e.toString(),context);
    }
  }

  Future<void>caseEventException(String message,BuildContext context)async{
    isPhoneReplace = false;
    print("FirebaseAuthException");
    Navigator.pop(context);
    Navigator.pop(context);
    showMessageWithAwesomeDialog(message:message, dialogType:DialogType.error,nigAction: (){},nigActionName: "Cancel",title: "Error", context: context);
  }
}