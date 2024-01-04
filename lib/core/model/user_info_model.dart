import 'package:hive/hive.dart';
part 'user_info_model.g.dart';
@HiveType(typeId: 0)
class UserInformationModel extends HiveObject{
  @HiveField(0)
  String? fullName;
  @HiveField(1)
  String? id;
  @HiveField(2)
  String? phoneNumber;
  @HiveField(3)
  bool? isAccountSocial;
  static const collectionName = "users";
  @HiveField(4)
  String? email;
  @HiveField(5)
  String? pathImage;
  UserInformationModel({ this.fullName, this.email, this.id,this.phoneNumber,this.pathImage,this.isAccountSocial});
  UserInformationModel.formFireStore(Map<String,dynamic>?data):this(
    pathImage: data?['pathImage'],
    email: data?['email'],
    id: data?['id'],
    isAccountSocial: data?['isAccountSocial'],
    fullName: data?['name'],
    phoneNumber: data?["phone"],
  );
  @override
  Map<String,dynamic>toFireStore(){
    return {
     "name":fullName,
      "pathImage":pathImage,
      "phone":phoneNumber,
      "email":email,
      "id":id,
      "isAccountSocial":isAccountSocial,
    };
  }

  @override
  String toString() {
    return 'InformationUserModel{fullName: $fullName, email: $email, phoneNumber: $phoneNumber, pathImage: $pathImage}';
  }
}