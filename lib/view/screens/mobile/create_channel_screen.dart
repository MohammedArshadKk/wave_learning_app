import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view_model/blocs/channel%20createtion%20bloc/channel_creation_bloc.dart';
import 'package:wave_learning_app/view_model/blocs/check%20channel%20created%20or%20not/channel_created_or_not_bloc.dart';
import 'package:wave_learning_app/view_model/blocs/get%20channel%20details%20bloc/get_channel_details_bloc.dart';
import 'package:wave_learning_app/view/utils/custom%20widgets/custom_loading.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/widgets/create%20channel%20widgets/channel_create_text_form_filed.dart';
import 'package:wave_learning_app/view/widgets/create%20channel%20widgets/create_button.dart';
import 'package:wave_learning_app/view/widgets/create%20channel%20widgets/create_channel_icon_non_selected_wedget.dart';
import 'package:wave_learning_app/view/widgets/create%20channel%20widgets/create_icon_picked_widget.dart';
import 'package:wave_learning_app/view/widgets/create%20channel%20widgets/edit_icon_non_selected_wedget.dart';
import 'package:wave_learning_app/view/widgets/create%20channel%20widgets/edit_icon_selected_wedget.dart';

class CreateChannelScreen extends StatefulWidget {
  const CreateChannelScreen(
      {super.key,
      required this.text,
      this.name,
      this.description,
      this.subject,
      this.documentid,
      this.channelIcon});
  final String text;
  final String? name;
  final String? description;
  final String? subject;
  final String? documentid;
  final String? channelIcon;
  @override
  State<CreateChannelScreen> createState() => _CreateChannelScreenState();
}

class _CreateChannelScreenState extends State<CreateChannelScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  File? icon;
  late TextEditingController channelNameController;
  late TextEditingController channelDescriptionController;
  late TextEditingController channelfocusedSubjectController;

  @override
  void initState() {
    super.initState();
    channelNameController = TextEditingController(text: widget.name);
    channelDescriptionController =
        TextEditingController(text: widget.description);
    channelfocusedSubjectController =
        TextEditingController(text: widget.subject);
  }

  @override
  void dispose() {
    channelNameController.dispose();
    channelDescriptionController.dispose();
    channelfocusedSubjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          BlocBuilder<ChannelCreationBloc, ChannelCreationState>(
            builder: (context, state) {
              if (widget.text == 'edit') {
                if (state is PickedIconState) {
                  icon = state.channelIcon;
                  return EditIconSelectedWedget(icon: state.channelIcon);
                }
                return EditIconNonSelectedWedget(
                    icon: widget.channelIcon.toString());
              } else {
                if (state is PickedIconState) {
                  icon = state.channelIcon;
                  return CreateIconPickedWidget(icon: icon!);
                }
                return const CreateChannelIconNonSelectedWedget();
              }
            },
          ),
          const SizedBox(
            height: 40,
          ),
          BlocListener<ChannelCreationBloc, ChannelCreationState>(
            listener: (context, state) {
              if (state is ChannelCreationLoadingState) {
                customLoading(context);
              } else if (state is EditedState) {
                Navigator.pop(context);
                channelNameController.clear();
                channelDescriptionController.clear();
                channelfocusedSubjectController.clear();
                Navigator.pop(context);
                context
                    .read<GetChannelDetailsBloc>()
                    .add(FetchChanneldetailsEvent(uid: _auth.currentUser!.uid));
                // icon = null;
              } else if (state is ChannelCreatedstate) {
                Navigator.pop(context);
                channelNameController.clear();
                channelDescriptionController.clear();
                channelfocusedSubjectController.clear();
                Navigator.pop(context);
                context.read<ChannelCreatedOrNotBloc>().add(
                    ChekingChannelcreatedEvent(uid: _auth.currentUser!.uid));
              } else if (state is ChannelAlreadycreatedState) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('You already created a channel')));
              }
            },
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: ChannelCreateTextFormFiled(
                      channelNameController: channelNameController,
                      channelDescriptionController:
                          channelDescriptionController,
                      channelfocusedSubjectController:
                          channelfocusedSubjectController),
                ),
                CreateButton(
                    formKey: _formKey,
                    channelNameController: channelNameController,
                    descriptionController: channelDescriptionController,
                    subjectController: channelfocusedSubjectController, 
                    text: widget.text,
                    documentid: widget.documentid.toString())
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
