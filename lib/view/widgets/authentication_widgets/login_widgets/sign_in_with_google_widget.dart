import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view_model/blocs/authentication%20bloc/authentication_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class SignInWithGoogleWidget extends StatelessWidget {
  const SignInWithGoogleWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    // var screenHeight = screenSize.height;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () {
          context.read<AuthenticationBloc>().add(SignInWithGoogleEvent());
        },
        child: CustomContainer(
          height: 60,
          width: screenWidth * 1,
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(20),
          borderColor: Border.all(color: AppColors.lightTextColor),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                  text: text,
                  color: AppColors.primaryColor,
                  fontSize: 20,
                  fontFamily: Fonts.labelText,
                  fontWeight: FontWeight.normal),
            ],
          )),
        ),
      ),
    );
  }
}
