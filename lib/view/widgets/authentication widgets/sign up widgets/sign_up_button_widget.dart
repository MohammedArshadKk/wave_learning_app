import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/model/user_model.dart';
import 'package:wave_learning_app/view_model/blocs/authentication%20bloc/authentication_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class SignUpButtonWidget extends StatelessWidget {
  const SignUpButtonWidget(
      {super.key,
      required this.formKey,
      required this.emailController,
      required this.passwordController,
      required this.nameController});
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () {
          if (formKey.currentState!.validate()) {
            final user = UserModel(
                userName: nameController.text.trim(),
                email: emailController.text.trim());
            context.read<AuthenticationBloc>().add(SignUpEvent(
                user: user, password: passwordController.text.trim()));
          }
        },
        child: CustomContainer(
          height: 55,
          width: 400,
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20),
          child: Center(
              child: CustomText(
                  text: 'Get Started',
                  color: AppColors.backgroundColor,
                  fontSize: 25,
                  fontFamily: Fonts.labelText,
                  fontWeight: FontWeight.normal)),
        ),
      ),
    );
  }
}
