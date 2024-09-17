import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/screens/common_screens/custom_bottom_navigation_bar.dart';
import 'package:wave_learning_app/view/screens/web/web_login_screen.dart';
import 'package:wave_learning_app/view/screens/web/web_navigation.dart';
import 'package:wave_learning_app/view/screens/web/web_verification_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_loading.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view/widgets/mobile/authentication_widgets/sign_up_widgets/sign_up_button_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/authentication_widgets/sign_up_widgets/sign_up_text_form_field.dart';
import 'package:wave_learning_app/view/widgets/web/image_auth_web.dart';
import 'package:wave_learning_app/view/widgets/web/sign_in_with_google.dart';
import 'package:wave_learning_app/view/widgets/web/web_auth_text.dart';
import 'package:wave_learning_app/view/widgets/web/web_login/dont_have_account_text.dart';
import 'package:wave_learning_app/view_model/blocs/authentication%20bloc/authentication_bloc.dart';

class WebSignUpScreen extends StatelessWidget {
  WebSignUpScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    double horizontalPadding = screenWidth * 0.05;
    double verticalPadding = screenHeight * 0.05;

    return ScaffoldMessenger(
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
               if (state is AuthLoadingState) {
                customLoading(context);
              } else if (state is AuthenticatedState) {
                Navigator.pop(context);
                Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) =>  WebVerificationScreen()),
                );
              } else if (state is SignInWithGooglestate) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (ctx) => const WebNavigationScreen()));
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ImageAuthWeb(
                      image: AppImages.signUpImage,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => WebLoginScreen()));
                              },
                              child: const DontAndHaveAccountText(
                                text1: 'have an account?',
                                text2: 'Sign in',
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            WebAuthText(
                              text: 'Sign Up',
                              fontSize: screenHeight * 0.04,
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            const SignInWithGoogle(
                              text: 'Sign up with google',
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            WebAuthText(
                              text: 'Or sign up manually',
                              fontSize: screenHeight * 0.02,
                            ),
                            SizedBox(height: screenHeight * 0.05),
                            Form(
                              key: formKey,
                              child: SignUpTextFormField(
                                emailController: emailController,
                                passwordController: passwordController,
                                nameController: nameController,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            SignUpButtonWidget(
                              formKey: formKey,
                              emailController: emailController,
                              passwordController: passwordController,
                              nameController: nameController,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
