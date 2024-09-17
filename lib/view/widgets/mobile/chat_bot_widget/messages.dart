import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class ChatBotMessagesWidget extends StatelessWidget {
  const ChatBotMessagesWidget({super.key, required this.isFromuser, this.text});
  final bool isFromuser;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: isFromuser
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 204, 203, 203)),
                        child: Center(
                          child: CustomText(
                              text: 'You',
                              color: AppColors.secondaryColor,
                              fontSize: 14,
                              fontFamily: Fonts.primaryText,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      CustomText(
                          text: text.toString(),
                          color: AppColors.secondaryColor,
                          fontSize: 18,
                          fontFamily: Fonts.primaryText,
                          fontWeight: FontWeight.normal),
                    ],
                  )
                : Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 204, 203, 203)),
                          child: Center(
                            child: CustomText(
                                text: 'AI',
                                color: AppColors.secondaryColor,
                                fontSize: 14,
                                fontFamily: Fonts.primaryText,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              text.toString(),      
                              speed: Duration(milliseconds: 10),
                              textStyle:   TextStyle(
                                fontSize: 18,
                                color: AppColors.secondaryColor,
                                fontFamily:Fonts.primaryText, 
                              ),
                            ),
                            
                          ],
                          isRepeatingAnimation: false,   
                          totalRepeatCount: 1,
                        ),
                      ],
                    ),
                ))
      ],
    );
  }
}
