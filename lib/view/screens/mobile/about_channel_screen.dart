import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view_model/blocs/get_channel_details_bloc/get_channel_details_bloc.dart';
import 'package:wave_learning_app/view/screens/mobile/create_channel_screen.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_loading.dart';
import 'package:wave_learning_app/view/widgets/about_channel_widgets/about_image_widget.dart';
import 'package:wave_learning_app/view/widgets/about_channel_widgets/channel_details_widget.dart';
import 'package:wave_learning_app/view/widgets/about_channel_widgets/name_and_members.dart';

class AboutChannelScreen extends StatefulWidget {
  const AboutChannelScreen({
    super.key,
  });
  @override
  State<AboutChannelScreen> createState() => _AboutChannelScreenState();
}

class _AboutChannelScreenState extends State<AboutChannelScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    final channeldetails = context.read<GetChannelDetailsBloc>();

      channeldetails.add(FetchChanneldetailsEvent(uid: _auth.currentUser!.uid));
 

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetChannelDetailsBloc, GetChannelDetailsState>(
      listener: (context, state) {
        if (state is LoadingState) {
          customLoading(context);
        } else {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: AppColors.backgroundColor),
            backgroundColor: AppColors.primaryColor,
            toolbarHeight: 100,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    if (state is ChannelFetchedState) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => CreateChannelScreen(
                                text: 'edit',
                                name: state.channelModel.channelName,
                                description: state.channelModel.description,
                                subject: state.channelModel.focusedSubject,
                                documentid: state.documentId,
                                channelIcon: state.channelModel.channelIconUrl,
                              )));
                    }
                  },
                  icon: const Icon(
                    Icons.edit_document,
                  ),
                ),
              )
            ],
          ),
          backgroundColor: AppColors.backgroundColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: state is ChannelFetchedState
                  ? Column(
                      children: [
                        AboutImageWidget(
                            icon: state.channelModel.channelIconUrl.toString()),
                        NameAndMembers(name: state.channelModel.channelName),
                        ChannelDetailsWidget(
                            email: state.channelModel.email,
                            description: state.channelModel.description,
                            focusedSubject: state.channelModel.focusedSubject)
                      ],
                    )
                  : state is ErrorState
                      ? const Center(
                          child: Text('Error'),
                        )
                      : Container(),
            ),
          ),
        );
      },
    );
  }
}
