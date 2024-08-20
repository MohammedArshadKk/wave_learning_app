import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/app_bar_text.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/icons.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class UserVideosScreen extends StatelessWidget {
  const UserVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.backgroundColor),
          backgroundColor: AppColors.primaryColor,
          title: const AppBarText(
            text: 'YourVideos',
          ),
          toolbarHeight: 100,
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomContainer(
                height: 120,
                width: width,
                color: AppColors.backgroundColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomContainer(
                        height: 100,
                        width: 180,
                        color: AppColors.primaryColor,
                        borderColor:
                            Border.all(color: AppColors.lightTextColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              text: 'Flutter Tutorial',
                              color: AppColors.secondaryColor,
                              fontSize: 20,
                              fontFamily: Fonts.labelText,
                              fontWeight: FontWeight.w500),
                          CustomText(
                              text: '1 day ago',
                              color: AppColors.secondaryColor,
                              fontSize: 17,
                              fontFamily: Fonts.labelText,
                              fontWeight: FontWeight.w500),
                          Row(
                            children: [
                              const Icon(Icons.thumb_up_alt_outlined),
                              const SizedBox(
                                width: 5,
                              ),
                              CustomText(
                                  text: '100',
                                  color: AppColors.secondaryColor,
                                  fontSize: 17,
                                  fontFamily: Fonts.labelText,
                                  fontWeight: FontWeight.w500),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
