import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view_model/blocs/authentication%20bloc/authentication_bloc.dart';
import 'package:wave_learning_app/view/screens/common_screens/custom_bottom_navigation_bar.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_loading.dart';
import 'package:wave_learning_app/view/widgets/authentication_widgets/login_widgets/dont_have_an_account_text_widget.dart';
import 'package:wave_learning_app/view/widgets/authentication_widgets/login_widgets/forgot_password_widget.dart';
import 'package:wave_learning_app/view/widgets/authentication_widgets/login_widgets/login_button_widget.dart';
import 'package:wave_learning_app/view/widgets/authentication_widgets/login_widgets/login_image_widgets.dart';
import 'package:wave_learning_app/view/widgets/authentication_widgets/login_widgets/login_text_form_widgets.dart';
import 'package:wave_learning_app/view/widgets/authentication_widgets/login_widgets/sign_in_with_google_widget.dart';

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({super.key});

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (ctx) => const CustomBottomNavigationBar()));
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
                key: formKey,
                child: Column(
                  children: [
                    const LoginImageWidgets(),
                    LoginTextFormWidgets(
                        emailController: emailController,
                        passwordController: passwordController),
                    const ForgotPasswordWidget(),
                    LoginButtonWidget(
                        formKey: formKey,
                        emailController: emailController,
                        passwordController: passwordController),
                    const DontHaveAnAccountTextWidget(),
                    const SignInWithGoogleWidget(
                      text: 'Sign in with google',
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
