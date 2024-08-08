import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class ChannelDetailsWidget extends StatelessWidget {
  const ChannelDetailsWidget(
      {super.key,
      required this.email,
      required this.description,
      required this.focusedSubject});
  final String email;
  final String description;
  final String focusedSubject;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.topLeft,
            child: CustomText(
                text: 'Email',
                color: AppColors.secondaryColor,
                fontSize: 24,
                fontFamily: Fonts.labelText,
                fontWeight: FontWeight.normal),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Material(
                elevation: 20,
                color: AppColors.backgroundColor,
                child: Container(
                  width: screenWidth * 0.87,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CustomText(
                        text: email,
                        color: AppColors.secondaryColor,
                        fontSize: 16,
                        fontFamily: Fonts.labelText,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.topLeft,
            child: CustomText(
                text: 'Description',
                color: AppColors.secondaryColor,
                fontSize: 24,
                fontFamily: Fonts.labelText,
                fontWeight: FontWeight.normal),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Material(
                elevation: 20,
                color: AppColors.backgroundColor,
                child: Container(
                  width: screenWidth * 0.87,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CustomText(
                        text: description,
                        color: AppColors.secondaryColor,
                        fontSize: 16,
                        fontFamily: Fonts.labelText,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.topLeft,
            child: CustomText(
                text: 'Focused subjects',
                color: AppColors.secondaryColor,
                fontSize: 24,
                fontFamily: Fonts.labelText,
                fontWeight: FontWeight.normal),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Material(
                elevation: 20,
                color: AppColors.backgroundColor,
                child: Container(
                  width: screenWidth * 0.87,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CustomText(
                        text: focusedSubject,
                        color: AppColors.secondaryColor,
                        fontSize: 16,
                        fontFamily: Fonts.labelText,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
