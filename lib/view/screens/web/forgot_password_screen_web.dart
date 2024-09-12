import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view/widgets/mobile/authentication_widgets/forgot_password_screen_widgets/after_link_send_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/authentication_widgets/forgot_password_screen_widgets/before_send_link_widget.dart';
import 'package:wave_learning_app/view/widgets/web/image_auth_web.dart';
import 'package:wave_learning_app/view_model/blocs/authentication%20bloc/authentication_bloc.dart';

class ForgotPasswordScreenWeb extends StatelessWidget {
  ForgotPasswordScreenWeb({super.key});
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageAuthWeb(image: AppImages.forgotPasswordImage),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(top: 200),
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is ForgotPasswordLinkSendedState) {
                  Future.delayed(const Duration(seconds: 15), () {
                    Navigator.pop(context);
                  });
                }
                return state is ForgotPasswordLinkSendedState
                    ? const AfterLinkSendWidget()
                    : BeforeSendLinkWidget(emailController: emailController);
              },
            ),
          ))
        ],
      ),
    );
  }
}
