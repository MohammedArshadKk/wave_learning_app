import 'package:flutter/material.dart';
import 'package:wave_learning_app/model/channel_model.dart';
import 'package:wave_learning_app/view/screens/mobile/channel_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class ChannelsList extends StatelessWidget {
  const ChannelsList({super.key, required this.channelList});
  final List<ChannelModel> channelList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: channelList.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      itemBuilder: (context, index) {
        final ChannelModel channel = channelList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: CustomContainer(
              height: 100,
              width: double.infinity,
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(15),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.lightTextColor.withOpacity(0.5),
                  child: ClipOval(
                    child: Image.network(
                      channel.channelIconUrl.toString(),
                      fit: BoxFit.fill,
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
                title: CustomText(
                  text: channel.channelName,
                  color: AppColors.primaryColor,
                  fontSize: 18,
                  fontFamily: Fonts.primaryText,
                  fontWeight: FontWeight.w600,
                ),
                subtitle: CustomText(
                  text: '${20 + index} members',
                  color: AppColors.lightTextColor,
                  fontSize: 14,
                  fontFamily: Fonts.primaryText,
                  fontWeight: FontWeight.normal,
                ),
                trailing: CustomContainer(
                  height: 35,
                  width: 85,
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  child: Center(
                    child: CustomText(
                        text: 'view channel',
                        color: AppColors.backgroundColor,
                        fontSize: 10,
                        fontFamily: Fonts.primaryText,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => ChannelScreen(channelModel: channel)));
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
