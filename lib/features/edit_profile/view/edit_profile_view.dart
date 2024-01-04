import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_management/core/widget/app_bar/custom_leading_item.dart';
import 'package:task_management/core/widget/dialogs/show_dialog_upload_image.dart';
import 'package:task_management/features/edit_profile/view/widgets/custom_form_field_password_edit_profile.dart';
import 'package:task_management/features/edit_profile/view/widgets/custom_pick_image_edit_profile.dart';
import '../../../core/base/base_state.dart';
import '../../../core/model/user_info_model.dart';
import '../../../core/style/colors/application_color.dart';
import '../../../core/widget/TextFormField/custom_form_field.dart';
import '../../../provider/user_information_provider.dart';
import '../../auth/sign up/view/widget/custom_phone_number_input.dart';
import '../navigator/edit_profile_navigator.dart';
import '../view model/edit_profile_view_model.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  static const String routeName = "EditProfileView";

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends BaseState<EditProfileView, EditProfileViewModel> implements EditProfileNavigator {
  var formKey = GlobalKey<FormState>();
  late UserInformationModel userInformationModel;
  late TextEditingController phoneNumberController;
  bool thereIsAChange = false;
  @override
  void initState() {
    super.initState();
    userInformationModel =
        Provider.of<UserInformationProvider>(context, listen: false).userInformationModel;
    viewModel.fullName = userInformationModel.fullName;
    phoneNumberController = TextEditingController(text: userInformationModel.phoneNumber?.substring(3));
  }
  double sizeBetweenField = 25;
  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: CustomLeadingItem(
                      icon: Icons.arrow_back_ios_new,
                      onPressed: (){
                        Provider.of<UserInformationProvider>(context,listen: false).pageViewController(0,speed: 100);
                      }, colorIcon: Colors.black,
                    )
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  InkWell(
                    onTap: () {
                      showDialogUploadImage(
                          context: context,
                          onPressedCamera: ()async{
                            await viewModel.onPressedCamera();
                            await savedImageInFireBaseStorage();
                          },
                          onPressedGallery: ()async{
                            await viewModel.onPressedGallery();
                            await savedImageInFireBaseStorage();
                          }
                      );
                    },
                    splashColor: Colors.transparent,
                    child: const CustomPickImageEditProfile()
                  ),
                  Transform.translate(
                      offset: const Offset(60, -30),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 30,
                      )),
                  CustomFormField(
                    textLabel: "Name",
                    initialValue: viewModel.fullName,
                    textInputType: TextInputType.text,
                    functionValidate: (String? value) {
                      if (value!.trim().isEmpty) {
                        return AppLocalizations.of(context)!.please_enter_your_name;
                      } else if (value.contains(" ") == false) {
                        return AppLocalizations.of(context)!
                            .enter_your_binary_name_at_least;
                      }
                    },
                    hintText: '',
                    functionOnChanged: (String? value) {
                      print(value);
                      viewModel.fullName = value;
                    },
                  ),
                  SizedBox(height: sizeBetweenField),
                   CustomFormFieldPasswordEditProfile(
                    functionValidate: (String? value){
                      if (value!.trim().isEmpty) {
                        return AppLocalizations.of(context)!.please_enter_password;
                      } else if (value.length < 6) {
                      return AppLocalizations.of(context)!
                          .please_enter_a_password_that_is_more_than_6_digits;
                      }
                    },
                  ),
                  SizedBox(height: sizeBetweenField),
                  CustomPhoneNumberInput(
                    phoneController: phoneNumberController,
                    onInputChanged: (PhoneNumber number) {
                      viewModel.onInputChangedPhoneNumber(number);
                    },
                    validator: (PhoneNumber value) {
                      return viewModel.validatorPhoneNumber();
                    },
                    onInputValidated: (bool isValid) {
                      viewModel.onInputValidated(isValid);
                    },
                  ),
                  SizedBox(height: sizeBetweenField + 30),
                  AnimatedButton(
                      pressEvent: () async{
                        await saveChanged();
                      },
                      text: "Save Changed",
                      buttonTextStyle: Theme.of(context).textTheme.displayMedium,
                      color: primaryColor)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> savedImageInFireBaseStorage()async{
    if(viewModel.pickedImage != null){
      await viewModel.uploadImageInFirebaseStorage();
      viewModel.userInformationModel = userInformationModel;
      viewModel.userInformationModel.pathImage = viewModel.urlDownloader;
      await viewModel.saveChangedInFireStore(isChangedText: false, message: "Your new full name has been uploaded successfully");
    }
  }
  Future<void> saveChanged()async{
    if(formKey.currentState?.validate() != true)return;
    await viewModel.saveChanges();

  }
  @override
  EditProfileViewModel initViewModel() {
    return EditProfileViewModel();
  }
}
