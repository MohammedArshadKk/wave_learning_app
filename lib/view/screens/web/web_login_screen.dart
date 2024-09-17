import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/screens/common_screens/custom_bottom_navigation_bar.dart';
import 'package:wave_learning_app/view/screens/web/web_navigation.dart';
import 'package:wave_learning_app/view/screens/web/web_sign_up_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_loading.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view/widgets/mobile/authentication_widgets/login_widgets/login_button_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/authentication_widgets/login_widgets/login_text_form_widgets.dart';
import 'package:wave_learning_app/view/widgets/web/sign_in_with_google.dart';
import 'package:wave_learning_app/view/widgets/web/web_auth_text.dart';
import 'package:wave_learning_app/view/widgets/web/web_login/dont_have_account_text.dart';
import 'package:wave_learning_app/view/widgets/web/image_auth_web.dart';
import 'package:wave_learning_app/view/widgets/web/web_login/forgot_password_widget_web.dart';
import 'package:wave_learning_app/view_model/blocs/authentication%20bloc/authentication_bloc.dart';

class WebLoginScreen extends StatelessWidget {
  WebLoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    double horizontalPadding = screenWidth * 0.05;
    double verticalPadding = screenHeight * 0.05;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is SignInWithGooglestate) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (ctx) => const WebNavigationScreen()));
          } else if (state is AuthenticatedState) {
            Navigator.pop(context);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (ctx) => const WebNavigationScreen()));
          } else if (state is AuthLoadingState) {
            customLoading(context);
          } else if (state is AuthErrorState) {
            if (Navigator.of(context).canPop()) {
              Navigator.pop(context); 
            }
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
                image: AppImages.signInImage,
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
                                builder: (ctx) => WebSignUpScreen()));
                          },
                          child: const DontAndHaveAccountText(
                            text1: 'Don’t have an account?',
                            text2: 'Sign up',
                          )),
                      SizedBox(height: screenHeight * 0.02),
                      WebAuthText(
                        text: 'Sign in',
                        fontSize: screenHeight * 0.04,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      const SignInWithGoogle(
                        text: 'Sign in with google',
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      WebAuthText(
                        text: 'Or sign in manually',
                        fontSize: screenHeight * 0.02,
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      Form(
                        key: formKey,
                        child: LoginTextFormWidgets(
                          emailController: emailController,
                          passwordController: passwordController,
                        ),
                      ),
                      const ForgotPasswordWidgetWeb(),
                      SizedBox(height: screenHeight * 0.02),
                      LoginButtonWidget(
                        formKey: formKey,
                        emailController: emailController,
                        passwordController: passwordController,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
