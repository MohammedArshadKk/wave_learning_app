import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/model/repositories/auth_repository.dart';
import 'package:wave_learning_app/model/user_model.dart';
import 'package:wave_learning_app/utils/colors.dart';
import 'package:wave_learning_app/utils/images_fonts.dart';
import 'package:wave_learning_app/view%20model/blocs/authentication%20bloc/authentication_bloc.dart';
import 'package:wave_learning_app/view/screens/common%20screens/custom_bottom_navigation_bar.dart';
import 'package:wave_learning_app/view/screens/mobile/mobile_login_screen.dart';
import 'package:wave_learning_app/view/screens/mobile/verification_screen.dart';
import 'package:wave_learning_app/view/widgets/custom%20widgets/custom_container.dart';
import 'package:wave_learning_app/view/widgets/custom%20widgets/custom_image_asset.dart';
import 'package:wave_learning_app/view/widgets/custom%20widgets/custom_text.dart';
import 'package:wave_learning_app/view/widgets/custom%20widgets/custom_text_form_field.dart';

class MobileSignUpScreen extends StatelessWidget {
  MobileSignUpScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthLoadingState) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                );
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
                    CustomImageAsset(
                      image: AppImages.signUpImage,
                      height: screenHeight * 0.38,
                      width: double.infinity,
                      padding: 25,
                      text: 'Sign up',
                    ),
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
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
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
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            final user = UserModel(
                                userName: nameController.text.trim(),
                                email: emailController.text.trim());
                            context.read<AuthenticationBloc>().add(SignUpEvent(
                                user: user,
                                password: passwordController.text.trim()));
                            // AuthRepository().verifyUser();
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
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                            text: 'Don’t have an account?',
                            color: AppColors.primaryColor,
                            fontSize: 16,
                            fontFamily: Fonts.labelText,
                            fontWeight: FontWeight.normal),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => MobileLoginScreen()));
                          },
                          child: CustomText(
                              text: 'Sign up',
                              color: AppColors.primaryColor,
                              fontSize: 16,
                              fontFamily: Fonts.labelText,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        onTap: () {
                          context
                              .read<AuthenticationBloc>()
                              .add(SignInWithGoogleEvent());
                        },
                        child: CustomContainer(
                          height: 60,
                          width: screenWidth * 1,
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          borderColor:
                              Border.all(color: AppColors.lightTextColor),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                  text: 'Sign up with google',
                                  color: AppColors.primaryColor,
                                  fontSize: 20,
                                  fontFamily: Fonts.labelText,
                                  fontWeight: FontWeight.normal),
                            ],
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
