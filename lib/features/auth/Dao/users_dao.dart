import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/model/user_info_model.dart';

class UsersDao{
  static CollectionReference<UserInformationModel> getUsersCollection(){
    return FirebaseFirestore.instance.
    collection(UserInformationModel.collectionName)
        .withConverter<UserInformationModel>(
        fromFirestore: (snapshot, options) =>
            UserInformationModel.formFireStore(snapshot.data()),
        toFirestore: (value, options) => value.toFireStore(),
    );
  }
  static Future<void> createUser(UserInformationModel userModel)async{
    var usersCollection = getUsersCollection();
    var doc = usersCollection.doc(userModel.id);
    await doc.set(userModel);
  }
  static Future<void> removeUser(String uId)async{
    var usersCollection = getUsersCollection();
    var doc = usersCollection.doc(uId);
    await doc.delete();
  }
  static Future<UserInformationModel?> getUser(String uid)async{
    var doc = getUsersCollection().doc(uid);
    var docSnapshot = await doc.get();
    return docSnapshot.data();
  }
}