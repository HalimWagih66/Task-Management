import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../core/model/user_info_model.dart';

class UserInformationProvider extends ChangeNotifier{
   late UserInformationModel _informationUserModel;
   late UserCredential userCredential;
  UserInformationModel get informationUserModel => _informationUserModel;

  set informationUserModel(UserInformationModel value) {
    _informationUserModel = value;
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