import 'package:flutter/material.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_text_form_field.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController=TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: CustomText(
            text: 'Massage',
            color: AppColors.backgroundColor,
            fontSize: 26,
            fontFamily: Fonts.labelText,
            fontWeight: FontWeight.w500),
      ),
      body: Column(
        children: [
          CustomContainer(
            height: 100,
            width: double.infinity,
            color: AppColors.primaryColor,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextFormField(
                labelText: 'Search',
                fontFamily: Fonts.labelText,
                fontWeight: FontWeight.normal,
                padding: 20,
                fontSize: 14,
                textColor: AppColors.secondaryColor,
                paddingForm: 30,
                borderRadius: 20,
                color: AppColors.backgroundColor,
                controller: searchController,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 20,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            'https://freebiehive.com/wp-content/uploads/2022/10/Google-Flutter-Icon-PNG-758x473.jpg'),
                      ),
                      title: CustomText(
                          text: 'group ${index + 1}',
                          color: AppColors.secondaryColor,
                          fontSize: 20,
                          fontFamily: Fonts.labelText,
                          fontWeight: FontWeight.normal),
                      subtitle: CustomText(
                          text: 'new video uploaded',
                          color: AppColors.lightTextColor,
                          fontSize: 14,
                          fontFamily: Fonts.labelText,
                          fontWeight: FontWeight.normal),
                      trailing: CircleAvatar(
                        radius: 10,
                        backgroundColor: const Color.fromARGB(255, 6, 240, 127),
                        child: CustomText(
                            text: '${index + 1}',
                            color: AppColors.backgroundColor,
                            fontSize: 10,
                            fontFamily: Fonts.labelText,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
