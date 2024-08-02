import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/utils/colors.dart';
import 'package:wave_learning_app/utils/images_fonts.dart';
import 'package:wave_learning_app/view%20model/blocs/authentication%20bloc/authentication_bloc.dart';
import 'package:wave_learning_app/view/widgets/custom%20widgets/custom_container.dart';
import 'package:wave_learning_app/view/widgets/custom%20widgets/custom_image_asset.dart';
import 'package:wave_learning_app/view/widgets/custom%20widgets/custom_text.dart';
import 'package:wave_learning_app/view/widgets/custom%20widgets/custom_text_form_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomImageAsset(
                image: AppImages.forgotPasswordImage,
                height: 300,
                width: double.infinity,
              ),
            ),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if(state is ForgotPasswordLinkSendedState){
                  Future.delayed(Duration(minutes: 10),(){
                    Navigator.pop(context);
                  });
                }
                return state is ForgotPasswordLinkSendedState
                    ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          children: [
                            CustomText(
                                text: 'We sent a reset password link to',
                                color: AppColors.secondaryColor,
                                fontSize: 20,
                                fontFamily: Fonts.labelText,
                                fontWeight: FontWeight.normal),
                            CustomText(
                                text: 'email',
                                color: AppColors.secondaryColor,
                                fontSize: 20,
                                fontFamily: Fonts.labelText,
                                fontWeight: FontWeight.normal)
                          ],
                        ),
                    )
                    : Column(
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
                          CustomText(
                              text: 'We sent a reset password link to',
                              color: AppColors.secondaryColor,
                              fontSize: 20,
                              fontFamily: Fonts.labelText,
                              fontWeight: FontWeight.normal),
                          CustomText(
                              text: 'email',
                              color: AppColors.secondaryColor,
                              fontSize: 20,
                              fontFamily: Fonts.labelText,
                              fontWeight: FontWeight.normal),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: GestureDetector(
                              onTap: () {
                                context.read<AuthenticationBloc>().add(
                                    ForgotPasswordEvent(
                                        email: emailController.text));
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
