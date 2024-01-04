import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task_management/core/const/constant.dart';
import 'package:task_management/features/auth/Dao/users_dao.dart';
import '../core/model/user_info_model.dart';

class UserInformationProvider extends ChangeNotifier{
  PageController pageController = PageController();
  UserInformationProvider(){
    userInformationModel = UserInformationModel();
    initializeUserInformation();
  }
  void initializeUserInformation()async{
    bool result = await InternetConnectionChecker().hasConnection;
    if(result){
      userInformationModel = (await UsersDao.getUser(FirebaseAuth.instance.currentUser!.uid)!)!;
      notifyListeners();
    }else{
      var userBox = Hive.box<UserInformationModel>(kUserInformationBox);
      userInformationModel = userBox.get("userInformationModel")!;
    }
    print("initState $userInformationModel");
  }

   late UserInformationModel _userInformationModel;
   late UserCredential userCredential;
 UserInformationModel get userInformationModel => _userInformationModel;

  set userInformationModel(UserInformationModel value) {
    _userInformationModel = value;
  }
  Future<void> pageViewController(int page ,{int speed = 500})async{
    await pageController.animateToPage(page, duration: Duration(milliseconds: speed), curve: Curves.bounceInOut);
  }

 // final ReceivePort _port = ReceivePort();

  // Future<void>downloadImage()async{
  //   FlutterDownloader.enqueue(
  //       url: url,
  //       savedDir: savedDir
  //   )
  // }
  // Future<void>downloadImage()async{
  //   try {
  //     var ref = FirebaseStorage.instance.ref().child("halemwagih6@gmail.jpg");
  //     final url = await ref.getDownloadURL();
  //     final dir = await getApplicationDocumentsDirectory();
  //     final path = File('${dir.path}/${ref.name}');
  //     // Response response = await Dio().download(url, path.path);
  //     // ImageGallerySaver.saveImage(
  //     //     Uint8List.fromList(response.data),
  //     //     quality: 60,
  //     //     name: "hello"
  //     // );
  //     var respons = await Dio().get(
  //         url,
  //         options: Options(responseType: ResponseType.bytes));
  //     final result = await ImageGallerySaver.saveImage(
  //         Uint8List.fromList(respons.data),
  //         quality: 60,
  //         name: "mm");
  //     print("ref $ref");
  //     print("dir $url");
  //     print("dir $dir");
  //     print("path $path");
  //     print("resu ${result.toString()}");
  //     print("response.data ${respons.data.toString()}");
  //     print("success");
  //   } on Exception catch (e) {
  //     print(e.toString());
  //   }
  //
  // }

}