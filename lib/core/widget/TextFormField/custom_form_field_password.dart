import 'package:flutter/material.dart';
import 'package:task_management/core/widget/TextFormField/custom_form_field.dart';

class CustomFormFieldPassword extends StatelessWidget {
  const CustomFormFieldPassword({super.key, required this.onPressedSuffixIcon, required this.functionValidate, required this.isHidePassword, this.passwordController, required this.textLabel, this.functionOnChanged, this.initialValue,});
  final Function onPressedSuffixIcon;
  final Function functionValidate;
  final TextEditingController? passwordController;
  final bool isHidePassword;
  final String textLabel;
  final Function? functionOnChanged;
  final String? initialValue;
  @override
  Widget build(BuildContext context) {
    return CustomFormField(
      initialValue: initialValue,
      hintText: "*********",
      textLabel: textLabel,
      inputField: passwordController,
      functionValidate: (text) {
        return functionValidate(text);
      },
      functionOnChanged:functionOnChanged!=null ?(String? value){
        functionOnChanged!(value);
      }:null,
      borderField: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.blue,
              style: BorderStyle.solid,
              width: 1)),
      onPressedSuffixIcon: () {
        onPressedSuffixIcon();
      },
      suffixIcon: isHidePassword?Icons.remove_red_eye:Icons.remove_red_eye_outlined,
      obscureText: isHidePassword,
    );
  }
}
