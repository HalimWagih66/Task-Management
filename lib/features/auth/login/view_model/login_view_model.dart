import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_management/core/const/constant.dart';
import 'package:task_management/core/model/user_info_model.dart';
import 'package:task_management/features/auth/Dao/users_dao.dart';
import '../../../../core/base/base_view_model.dart';
import '../../../../onboarding/view/on_boarding_view.dart';
import '../navigator/login_navigator.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator>{
  bool isHidePassword = true;
  IconData eyePassword = Icons.remove_red_eye;

  Future<void> login(String email,String password)async {
    navigator.showLoading();
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      if (userCredential.user?.emailVerified == true) {
        await returnUserFromFireStore(userCredential.user!.uid);
        navigator.navigatorPop();
        navigator.pushScreenAndRemoveUntil(routeName: OnBoardingView.routeName);
      } else {
        navigator.navigatorPop();
        navigator.showMessageSnackPar(message: "Please activate the account");
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if(e.code == "invalid-credential"){
        navigator.navigatorPop();
        navigator.showMessageSnackPar(message: "There is an error in the email or password");
      }
      else{
        navigator.navigatorPop();
        navigator.showMessageSnackPar(message: e.message??e.code);
      }
    } catch(e){
      navigator.navigatorPop();
      navigator.showMessageSnackPar(message: e.toString());
    }
  }
  Future<void>resetPassword({required String email})async{
    navigator.showLoading();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      navigator.navigatorPop();
      navigator.showMessageSnackPar(message: "A message has been sent to your account to change the password please go and change the password");
    } on Exception catch (_) {
      navigator.navigatorPop();
      navigator.showMessageSnackPar(message: "This email is not valid, modify it");
    }
  }
  Future<void>logout()async{
    print("logout");
    navigator.showLoading();
    await FirebaseAuth.instance.signOut();
    print(FirebaseAuth.instance.currentUser);
    navigator.navigatorPop();
  }
  void onPressedSuffixIcon(){
    isHidePassword = !isHidePassword;
    eyePassword = isHidePassword == true
        ? Icons.remove_red_eye
        : Icons.remove_red_eye_outlined;
    notifyListeners();
  }
  Future<void>returnUserFromFireStore(String uid)async{
    UserInformationModel? userInformationModel = await UsersDao.getUser(uid);
    var userBox = Hive.box<UserInformationModel>(kUserInformationBox);
    await userBox.put("userInformationModel",userInformationModel!);
    print(userBox.get("userInformationModel"));

  }
}