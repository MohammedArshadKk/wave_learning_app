import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view_model/blocs/authentication%20bloc/authentication_bloc.dart';
import 'package:wave_learning_app/view/widgets/mobile/authentication_widgets/forgot_password_screen_widgets/after_link_send_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/authentication_widgets/forgot_password_screen_widgets/before_send_link_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/authentication_widgets/forgot_password_screen_widgets/image_widget.dart';

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
           const ForgotPasswordImageWidget(),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is ForgotPasswordLinkSendedState) {
                  Future.delayed(const Duration(seconds: 30), () {
                    Navigator.pop(context);
                  });
                }
                return state is ForgotPasswordLinkSendedState
                    ? const AfterLinkSendWidget()
                    : BeforeSendLinkWidget(emailController: emailController);
              },
            ),
          ],
        ),
      ),
    );
  }
}
