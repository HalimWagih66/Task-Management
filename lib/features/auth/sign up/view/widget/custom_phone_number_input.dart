import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:task_management/core/widget/TextFormField/text_form_field_border.dart';

import '../../../../../core/style/colors/application_color.dart';


class CustomPhoneNumberInput extends StatelessWidget {
  const CustomPhoneNumberInput({super.key,
    required this.onInputChanged,
    required  this.validator,
    required  this.onInputValidated, this.phoneController, this.autofocus = false});
  final Function onInputChanged;
  final Function validator;
  final TextEditingController? phoneController;
  final Function onInputValidated;
  final bool autofocus;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Phone Number", style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: 13),
        IntlPhoneField(
          onChanged: (PhoneNumber number) {
            onInputValidated(number.isValidNumber());
            onInputChanged(number);
          },
          validator: (value) {
           return validator(value);
          },
          keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
          controller: phoneController,
          autofocus: autofocus,
          initialValue: "+20",
          style: Theme.of(context).textTheme.bodySmall,
          dropdownTextStyle: Theme.of(context).textTheme.bodySmall,
          decoration: InputDecoration(
            hintText: "ex.115 152 1156",
            focusedErrorBorder: fieldBorderDefault(color: Colors.transparent),
            hintStyle: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(letterSpacing: 1.5, decorationThickness: 0),
            enabledBorder: fieldBorderDefault(color: Colors.grey),
            errorBorder: fieldBorderDefault(color: Colors.transparent),
            filled: true,
            hintFadeDuration: const Duration(milliseconds: 250),
            fillColor: Colors.white,
            focusedBorder: fieldBorderDefault(color: primaryColor),
            errorStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w100,
              color: Colors.red,
            ),
          ),
        ),

      ],
    );
  }
}
