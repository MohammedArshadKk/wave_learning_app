import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_text_form_field.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class SignUpTextFormField extends StatelessWidget {
  const SignUpTextFormField(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.nameController});
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          labelText: 'Name',
          fontFamily: Fonts.labelText,
          fontWeight: FontWeight.normal,
          padding: 10,
          fontSize: 18,
          textColor: Colors.black,
          paddingForm: 20,
          borderRadius: 20,
          controller: nameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 15,
        ),
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 15,
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            } else if (value.length < 6) {
              return 'Password must be at least 6 characters long';
            }
            return null;
          },
        ),
      ],
    );
  }
}
