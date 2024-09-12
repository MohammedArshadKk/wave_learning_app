import 'package:flutter/material.dart';
import 'package:wave_learning_app/model/channel_model.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/widgets/mobile/channel_screen_widgets/contents_widget.dart';
import 'package:wave_learning_app/view/widgets/mobile/channel_screen_widgets/heading_widget.dart';

class AboutWidget extends StatelessWidget {
  const AboutWidget({super.key, required this.channelModel});
  final ChannelModel channelModel;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const HeadingWidget(text: 'Channel Name'),
                AboutContentsWidget(
                    width: width, content: channelModel.channelName),
                const HeadingWidget(text: 'Email'),
                AboutContentsWidget(width: width, content: channelModel.email),
                const HeadingWidget(text: 'members'),
                AboutContentsWidget(
                    width: width,
                    content:
                        "${channelModel.members.length.toString()} members"),
                const HeadingWidget(text: 'Description'),
                AboutContentsWidget(
                    width: width, content: channelModel.description),
              ],
            ),
          )),
    );
  }
}
