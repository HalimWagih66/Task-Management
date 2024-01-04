import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';
import 'package:task_management/features/edit_profile/view%20model/replace_phone_number_provider.dart';
import 'package:task_management/provider/user_information_provider.dart';
import '../../../core/base/base_view_model.dart';
import '../../../core/functions/image picker/image_picker_functions.dart';
import '../../../core/model/user_info_model.dart';
import '../../auth/Dao/users_dao.dart';
import '../../auth/sign up/view/sign_up_view.dart';
import '../navigator/edit_profile_navigator.dart';
import '../view/edit_profile_view.dart';
class EditProfileViewModel extends BaseViewModel<EditProfileNavigator>{
  late UserInformationModel userInformationModel;
  bool isValidPhoneNumber = false;
  String? phoneNumber;
  bool isHidePassword = true;
  late BuildContext context;
  String? password = "********";
 // bool isImageChanged = false;
  String? fullName;

  File? pickedImage;

  String? urlDownloader;
  void onInputValidated(bool isValid){
    if(isValid){
      isValidPhoneNumber = isValid;
    }else{
      isValidPhoneNumber = isValid;
    }
  }
  String? validatorPhoneNumber(){
    if(!isValidPhoneNumber){
      return "Invalid phone number.";
    }else{
      return null;
    }
  }
  void onInputChangedPhoneNumber(PhoneNumber number){
    if(isValidPhoneNumber){
      phoneNumber = number.completeNumber;
    }
  }
  Future<void> saveChanges()async{
    await checkChangeName();
    await checkChangePhoneNumber();
    await checkChangePassword();
  }
  Future<void> checkChangeName()async{
    if(fullName?.compareTo(Provider.of<UserInformationProvider>(context,listen: false).userInformationModel.fullName!) != 0){
      await saveFullNameInFireStore();
    }
  }
  Future<void>checkChangePhoneNumber()async{
    if(Provider.of<UserInformationProvider>(context,listen: false).userInformationModel.phoneNumber != phoneNumber && phoneNumber != null){
      await replacePhoneNumber();
    }
  }
  Future<void>saveFullNameInFireStore()async{
      userInformationModel = Provider.of<UserInformationProvider>(context,listen: false).userInformationModel;
      userInformationModel.fullName = fullName;
      await saveChangedInFireStore(isChangedText: true, message: "Your new full name has been uploaded successfully");
  }
  Future<void>checkChangePassword()async{
    if(password != "********"){
      await editPassword();
    }
  }

  Future<void>saveChangedInFireStore({required bool isChangedText,required String message})async{
    if(isChangedText){
      navigator.showLoading();
    }
    try {
      await UsersDao.createUser(userInformationModel);
      await navigator.showToastMessage(message);
      navigator.navigatorPop();
      notifyListeners();
    } on FirebaseException catch (e) {
      navigator.navigatorPop();
      navigator.showMessageSnackPar(message: e.message??e.code);
    }catch(e){
      navigator.navigatorPop();
      navigator.showMessageSnackPar(message: e.toString());
    }
  }
  Future<void> changePasswordInFireBaseAuthentication(String newPassword)async{
    await FirebaseAuth.instance.currentUser?.updatePassword(newPassword);
  }
  Future<void> replacePhoneNumber() async {
      navigator.showLoading();
    print("verifyPhoneNumber $phoneNumber");
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        print("verificationCompleted");
      },
      verificationFailed: (FirebaseAuthException e) {
         verificationFailedVerifyPhoneNumber(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        codeSentVerifyPhoneNumber(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
  Future<void> editPassword()async{
    try {
      navigator.showLoading();
      await FirebaseAuth.instance.currentUser?.updatePassword(password!);
      navigator.navigatorPop();
      navigator.showMessageSnackPar(message: "Password changed successfully");
    } on FirebaseAuthException catch (e) {
      navigator.navigatorPop();
      navigator.showMessageAwesome(title: "Error", dialogType: DialogType.error,message: e.message??e.code);
    }catch (e){
      navigator.navigatorPop();
      navigator.showMessageAwesome(title: "Error", dialogType: DialogType.error,message: e.toString());
    }
  }
  void verificationFailedVerifyPhoneNumber(FirebaseAuthException e) {
    navigator.navigatorPop();
    navigator.showMessageAwesome(
        message: e.message ?? e.code,
        dialogType: DialogType.error,
        title: "ERROR",
        nigActionName: "Cancel",
        nigAction: () {});
    print("verificationFailed");
  }

  void codeSentVerifyPhoneNumber(String verificationId) {
    print("codeSent");
    navigator.navigatorPop();
    var replacePhoneNumberProvider = Provider.of<ReplacePhoneNumberProvider>(context,listen: false);
    replacePhoneNumberProvider.phoneNumber = phoneNumber;
    replacePhoneNumberProvider.isPhoneReplace = true;
    replacePhoneNumberProvider.fullName = fullName;
    replacePhoneNumberProvider.verificationId = verificationId;
    navigator.pushScreenWithWidget(const SignUpView(selectedPage: 3));
    print("codeSent");
  }
  // Future<void> verifySmsCode(String smsCode) async {
  //   navigator.showLoading();
  //   try {
  //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //         verificationId: verificationId!, smsCode: smsCode
  //     );
  //    // isPhoneReplace = false;
  //     userInformationModel.phoneNumber = phoneNumber;
  //     navigator.navigatorPop();
  //     navigator.pushScreenAndRemoveUntil(routeName: EditProfileView.routeName);
  //     navigator.showToastMessage("Phone number has changed");
  //     print("verifySmsCode");
  //   } on FirebaseAuthException catch (e) {
  //     await caseEventException(e.message ?? e.code);
  //   }catch (e){
  //     await caseEventException(e.toString());
  //   }
  // }

  Future<void>caseEventException(String message)async{
    print("FirebaseAuthException");
    navigator.navigatorPop();
    navigator.pushScreenAndRemoveUntil(routeName: EditProfileView.routeName);
    navigator.showMessageAwesome(message:message, dialogType:DialogType.error,nigAction: (){},nigActionName: "Cancel",title: "Error");
  }


  Future<void> onPressedCamera() async {
    var tempPickedImage = await ImagePackerFunctions.cameraPicker();
    if (tempPickedImage != null) {
      changePickImage(tempPickedImage);
    }
    navigator.navigatorPop();
  }

  Future<void> onPressedGallery() async {
    File? tempPickedImage = await ImagePackerFunctions.galleryPicker();
    if (tempPickedImage != null) {
      changePickImage(tempPickedImage);
    }
    navigator.navigatorPop();
  }
  void onPressedSuffixIcon() {
    isHidePassword = !isHidePassword;
    notifyListeners();
  }
  void changePickImage(File pickImage) {
    pickedImage = pickImage;
    notifyListeners();
  }
  Future<void> uploadImageInFirebaseStorage() async {
    print("uploadImage");
    try {
      FirebaseStorage firebaseStorage = FirebaseStorage.instanceFor(
          bucket: "gs://task-management-952ef.appspot.com");
      Reference reference = firebaseStorage.ref().child(pathImage());
      UploadTask uploadTask = reference.putFile(pickedImage!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      urlDownloader = await taskSnapshot.ref.getDownloadURL();
      print("urlDownloader = $urlDownloader");
    } on FirebaseException catch (e) {
      navigator.showMessageSnackPar(message: e.message ?? e.code);
    } catch (e) {
      navigator.showMessageSnackPar(message: e.toString());
    }
  }

  String pathImage() {
    return p.basename(pickedImage!.path).replaceRange(
      0,
      p.basename(pickedImage!.path).lastIndexOf('.'),
      FirebaseAuth.instance.currentUser!.email!.substring(
        0,
        FirebaseAuth.instance.currentUser!.email!.lastIndexOf("."),
      ),
    );
  }
}