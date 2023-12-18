import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:task_management/core/base/base_state.dart';
import 'package:task_management/features/auth/Dao/users_dao.dart';
import 'package:task_management/features/edit_profile/view/edit_profile_view.dart';
import 'package:task_management/features/home%20layout/view%20model/home_view_model.dart';
import 'package:task_management/features/profile/view/profile_view.dart';
import 'package:task_management/provider/user_information_provider.dart';

import '../../../../core/const/constant.dart';
import '../../../../core/model/user_info_model.dart';
class HomeView extends StatefulWidget {
   const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView,HomeViewModel> {
  List<Widget> homeFragments = [];
  @override
  void initState() {
    homeFragments = [
      const ProfileView(),
      Container(),
      const EditProfileView(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: homeFragments.length,
          scrollDirection: Axis.vertical,
          controller: Provider.of<UserInformationProvider>(context,listen: false).pageController,
          itemBuilder: (context, index) => homeFragments[index],
      ),
    );
  }

  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }
  void initializeUserInformation()async{
    bool result = await InternetConnectionChecker().hasConnection;
    if(result){
      Provider.of<UserInformationProvider>(context,listen: false).userInformationModel = (await UsersDao.getUser(FirebaseAuth.instance.currentUser!.uid))!;
    }else{
      var userBox = Hive.box<UserInformationModel>(kUserInformationBox);
      Provider.of<UserInformationProvider>(context,listen: false).userInformationModel = userBox.get("userInformationModel")!;
    }
    print("initState ${Provider.of<UserInformationProvider>(context,listen: false).userInformationModel}");
  }

}
