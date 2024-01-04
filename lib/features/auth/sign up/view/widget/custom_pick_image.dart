import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/widget/pick_image/custom_circle_image.dart';
import '../../../../../core/style/colors/application_color.dart';
import '../../view model/sign_up_view_model.dart';

class CustomPickImage extends StatelessWidget {
  const CustomPickImage({super.key});
  @override
  Widget build(BuildContext context) {
    var providerSignUp = Provider.of<SignUpViewModel>(context);
    print("providerSignUp.pickImage ${providerSignUp.pickedImage}");
    return CustomCircleImage(imageProvider: providerSignUp.pickedImage != null ? FileImage(providerSignUp.pickedImage!):null,colorBorderCircle: providerSignUp.pickedImage==null?Colors.transparent:primaryColor);
  }
}
