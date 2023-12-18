import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:task_management/features/edit_profile/view%20model/edit_profile_view_model.dart';

import '../../../../core/widget/TextFormField/custom_form_field_password.dart';

class CustomFormFieldPasswordEditProfile extends StatelessWidget {
  const CustomFormFieldPasswordEditProfile({super.key, required this.functionValidate});
  final Function functionValidate;
  @override
  Widget build(BuildContext context) {
    var editProfileViewModel = Provider.of<EditProfileViewModel>(context);
    return CustomFormFieldPassword(
      textLabel: "Password",
      initialValue: editProfileViewModel.password,
      functionValidate: (String? value) {
        return functionValidate(value);
      },
      functionOnChanged: (String? value) {
        editProfileViewModel.password = value;
      }, onPressedSuffixIcon: (){
      editProfileViewModel.onPressedSuffixIcon();
    } ,isHidePassword: editProfileViewModel.isHidePassword,
    );
  }
}
