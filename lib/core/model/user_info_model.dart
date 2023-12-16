class UserInformationModel{
  String? fullName;
  String? id;
  String? phoneNumber;
  bool? isAccountSocial;
  static const collectionName = "users";
  String? email;
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