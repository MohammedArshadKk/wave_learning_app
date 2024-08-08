import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view%20model/blocs/authentication%20bloc/authentication_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_text_form_field.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class BeforeSendLinkWidget extends StatelessWidget {
  const BeforeSendLinkWidget({super.key, required this.emailController});
  final TextEditingController emailController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
            text: 'Enter your email',
            color: AppColors.secondaryColor,
            fontSize: 30,
            fontFamily: Fonts.labelText,
            fontWeight: FontWeight.bold),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextFormField(
            labelText: 'Email',
            fontFamily: Fonts.labelText,
            fontWeight: FontWeight.normal,
            padding: 10,
            fontSize: 18,
            textColor: Colors.black,
            paddingForm: 20,
            borderRadius: 20,
            controller: emailController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: GestureDetector(
            onTap: () {
              context
                  .read<AuthenticationBloc>()
                  .add(ForgotPasswordEvent(email: emailController.text.trim()));
            },
            child: CustomContainer(
              height: 55,
              width: 300,
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(20),
              child: Center(
                  child: CustomText(
                      text: 'Sent link',
                      color: AppColors.backgroundColor,
                      fontSize: 25,
                      fontFamily: Fonts.labelText,
                      fontWeight: FontWeight.normal)),
            ),
          ),
        ),
      ],
    );
  }
}
