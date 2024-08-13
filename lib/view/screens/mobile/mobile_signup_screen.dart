import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view_model/blocs/authentication%20bloc/authentication_bloc.dart';
import 'package:wave_learning_app/view/screens/common%20screens/custom_bottom_navigation_bar.dart';
import 'package:wave_learning_app/view/screens/mobile/verification_screen.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_loading.dart';
import 'package:wave_learning_app/view/widgets/authentication%20widgets/login%20widgets/sign_in_with_google_widget.dart';
import 'package:wave_learning_app/view/widgets/authentication%20widgets/sign%20up%20widgets/have_an_account_widget.dart';
import 'package:wave_learning_app/view/widgets/authentication%20widgets/sign%20up%20widgets/sign_image_widget.dart';
import 'package:wave_learning_app/view/widgets/authentication%20widgets/sign%20up%20widgets/sign_up_button_widget.dart';
import 'package:wave_learning_app/view/widgets/authentication%20widgets/sign%20up%20widgets/sign_up_text_form_field.dart';

class MobileSignUpScreen extends StatefulWidget {
  const MobileSignUpScreen({super.key});

  @override
  State<MobileSignUpScreen> createState() => _MobileSignUpScreenState();
}

class _MobileSignUpScreenState extends State<MobileSignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthLoadingState) {
                customLoading(context);
              } else if (state is AuthenticatedState) {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => VerificationScreen()),
                );
              } else if (state is SignInWithGooglestate) {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (ctx) => const CustomBottomNavigationBar()));
              } else if (state is UnAuthenticatedState) {
                Navigator.pop(context);
                log('error');
              } else if (state is AuthErrorState) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(state.error),
                  ),
                  backgroundColor: AppColors.alertColor,
                ));
              }
            },
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SignImageWidget(),
                    SignUpTextFormField(
                        emailController: emailController,
                        passwordController: passwordController,
                        nameController: nameController),
                    SignUpButtonWidget(
                        formKey: _formKey,
                        emailController: emailController,
                        passwordController: passwordController,
                        nameController: nameController),
                    const HaveAnAccountWidget(),
                    const SignInWithGoogleWidget(
                      text: 'Sign up with google',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
