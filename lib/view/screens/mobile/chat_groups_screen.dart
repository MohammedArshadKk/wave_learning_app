import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text_form_field.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/no_data_widget.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view/widgets/mobile/chat_groups_screen_widget/after_search.dart';
import 'package:wave_learning_app/view/widgets/mobile/chat_groups_screen_widget/chat_group_before_searching.dart';
import 'package:wave_learning_app/view_model/cubits/get_joined_channels/get_joined_channels_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/search_chat_groups_cubit/search_chat_groups_cubit.dart';

class ChatGroupScreen extends StatefulWidget {
  const ChatGroupScreen({super.key});

  @override
  State<ChatGroupScreen> createState() => _ChatGroupScreenState();
}

class _ChatGroupScreenState extends State<ChatGroupScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<GetJoinedChannelsCubit>().getJoinedChannels(_auth.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: CustomText(
          text: 'Message',
          color: AppColors.backgroundColor,
          fontSize: 26,
          fontFamily: Fonts.primaryText,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            CustomContainer(
              height: 100,
              width: double.infinity,
              color: AppColors.primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFormField(
                  onChanged: (p0) {
                    context.read<SearchChatGroupsCubit>().debounceSearchChannel(p0, _auth.currentUser!.uid);
                  },
                  labelText: 'Search',
                  fontFamily: Fonts.primaryText,
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
            // Ensure that the BlocBuilder is inside an Expanded widget
            Expanded(
              child: BlocBuilder<SearchChatGroupsCubit, SearchChatGroupsState>(
                builder: (context, state) {
                  if (state is SearchChatGroup) {
                    if (state.listChannel.isEmpty) {
                      return const Center(
                        child: NoDataWidget(
                          text: 'No search results',
                        ),
                      );
                    }
                    return AfterSearch(channelModelList: state.listChannel);
                  } else {
                    return ChatGroupBeforeSearching();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
