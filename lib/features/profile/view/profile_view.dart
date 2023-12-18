import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/core/widget/pick_image/custom_cached_network_image.dart';
import 'package:task_management/features/profile/view/widget/custom_view_field.dart';
import '../../../core/widget/app_bar/custom_app_bar.dart';
import '../../../provider/user_information_provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  static const String routeName = "ProfileView";

  @override
  Widget build(BuildContext context) {
    var userInformationProvider = Provider.of<UserInformationProvider>(context).userInformationModel;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CustomCachedNetworkImage(
                  urlImage: userInformationProvider.pathImage ?? "https://cdn-icons-png.flaticon.com/512/5087/5087579.png",
                  borderRadiusCircular: 0,
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: double.infinity),
              const CustomAppBar(titleAppBar: "PROFILE"),
              Align(
                heightFactor: 2,
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () => Provider.of<UserInformationProvider>(context,listen: false).pageViewController(2,speed: 200),
                  child: CustomCachedNetworkImage(
                      urlImage: userInformationProvider.pathImage??"https://cdn-icons-png.flaticon.com/512/5087/5087579.png",
                      borderRadiusCircular:100,
                      height: MediaQuery.of(context).size.height * 0.17,
                      width: MediaQuery.of(context).size.width * 0.33,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Center(
              child: Text(
            userInformationProvider.fullName??"".toUpperCase(),
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 21),
            textAlign: TextAlign.start,
          )),
          const SizedBox(height: 50),
          CustomViewField(
              text: userInformationProvider.fullName??"", label: "Name"),
          CustomViewField(text: userInformationProvider.email??"", label: "Email"),
          const CustomViewField(text: "********", label: "Password"),
          CustomViewField(
              text: userInformationProvider.phoneNumber??"",
              label: "Phone Number"),
        ],
      ),
    );
  }
}
