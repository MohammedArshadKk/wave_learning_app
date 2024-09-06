import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_button.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_loading.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view_model/cubits/chat_cubit/chat_cubit.dart';
import 'package:wave_learning_app/view_model/functions/chat_functions/pick_document.dart';

class SendFormWidget extends StatelessWidget {
  const SendFormWidget(
      {super.key,
      required this.massageController,
      required this.uid,
      required this.id});
  final TextEditingController massageController;
  final String uid;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.lightTextColor),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () async {
                  final result = await pickDocument();

                  if (result != null) {
                    final String documentPath =
                        result.files.single.path.toString();
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: CustomText(
                                    text: documentPath,
                                    color: AppColors.secondaryColor,
                                    fontSize: 15,
                                    fontFamily: Fonts.labelText,
                                    fontWeight: FontWeight.normal),
                              ),
                              BlocListener<ChatCubit, ChatState>(
                                listener: (context, state) {
                                  if (state is DocumentSening) {
                                    customLoading(context);
                                  } else if (state is DocumentSent) {
                                   context.read<ChatCubit>().fetchChatMessages(id);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  }
                                },
                                child: GestureDetector(
                                    onTap: () {
                                      context.read<ChatCubit>().sendDocument(
                                          File(documentPath), id, uid);
                                    },
                                    child: const CustomButton(text: 'send ')),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.insert_drive_file,
                    color: AppColors.primaryColor,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: massageController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: "Write a message...",
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none,
                  ),
                  textInputAction: TextInputAction.send,
                ),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                onPressed: () {
                  if (massageController.text.isNotEmpty) {
                    context
                        .read<ChatCubit>()
                        .sendMessage(id, uid, massageController.text);
                    massageController.clear();
                  }
                },
                backgroundColor: AppColors.primaryColor,
                elevation: 0,
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
