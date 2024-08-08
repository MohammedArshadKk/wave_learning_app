import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_text_form_field.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class LoginTextFormWidgets extends StatelessWidget {
  const LoginTextFormWidgets(
      {super.key,
      required this.emailController,
      required this.passwordController});
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          labelText: 'Email',
          fontFamily: Fonts.labelText,
          fontWeight: FontWeight.normal,
          padding: 10,
          fontSize: 18,
          textColor: Colors.black,
          paddingForm: 20,
          borderRadius: 20,
          controller: emailController,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextFormField(
          labelText: 'Password',
          fontFamily: Fonts.labelText,
          fontWeight: FontWeight.normal,
          padding: 10,
          fontSize: 18,
          textColor: Colors.black,
          paddingForm: 20,
          borderRadius: 20,
          controller: passwordController,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),
      ],
    );
  }
}
