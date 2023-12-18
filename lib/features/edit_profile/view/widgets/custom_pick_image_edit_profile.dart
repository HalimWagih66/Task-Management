import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/features/edit_profile/view%20model/edit_profile_view_model.dart';
import 'package:task_management/provider/user_information_provider.dart';
import '../../../../core/widget/pick_image/custom_cached_network_image.dart';
import '../../../../core/widget/pick_image/custom_circle_image.dart';

class CustomPickImageEditProfile extends StatelessWidget {
  const CustomPickImageEditProfile({super.key});
  @override
  Widget build(BuildContext context) {
    var editProfileViewModel = Provider.of<EditProfileViewModel>(context);
    return editProfileViewModel.pickedImage != null
        ? CustomCircleImage(
            colorBorderCircle: Colors.transparent,
            imageProvider: FileImage(editProfileViewModel.pickedImage!))
        : CustomCachedNetworkImage(
            urlImage: Provider.of<UserInformationProvider>(context).userInformationModel.pathImage ?? "",
            height: MediaQuery.of(context).size.height * 0.17,
            width: MediaQuery.of(context).size.height * 0.17,
            borderRadiusCircular: 100,
          );
  }
}
