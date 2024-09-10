import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view_model/blocs/fetch%20user%20data%20bloc/fetchuserdata_bloc.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_container.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';

class ProfileUserDetails extends StatelessWidget {
  ProfileUserDetails({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return Material(
        elevation: 10,
        shadowColor: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(25),
        child: CustomContainer(
          height: screenHeight * 0.25,
          width: screenWidth,
          color: AppColors.primaryColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          child: BlocBuilder<FetchuserdataBloc, FetchuserdataState>(
            builder: (context, state) {
              if (state is UserDataFetchedstate) {
                // var user = state.userData;
                return Center(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 40,
                      child: ClipOval(
                        child: Image.network(
                            _auth.currentUser!.photoURL.toString()),
                      ),
                    ),
                    title: CustomText(
                        text: state.userData.userName.toString(),
                        color: AppColors.backgroundColor,
                        fontSize: 25,
                        fontFamily: Fonts.primaryText,
                        fontWeight: FontWeight.w300),
                    subtitle: CustomText(
                        text: state.userData.email.toString(),
                        color: AppColors.backgroundColor,
                        fontSize: 15,
                        fontFamily: Fonts.primaryText,
                        fontWeight: FontWeight.w300),
                  ),
                );
              }
              return Container();
            },
            // )
          ),
        ));
  }
}
