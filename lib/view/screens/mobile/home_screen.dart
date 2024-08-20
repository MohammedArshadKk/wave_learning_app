import 'package:flutter/material.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import 'package:wave_learning_app/view/utils/colors.dart';
import 'package:wave_learning_app/view/utils/icons.dart';
import 'package:wave_learning_app/view/widgets/home%20widgets/drawer_widget.dart';
import 'package:wave_learning_app/view/widgets/home%20widgets/top_sheet_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: 100,
        leading: Builder(builder: (context) {
          return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: AppIcons.menuIcon);
        }),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    
                  },
                  child: AppIcons.searchIcon
                  ),
                const SizedBox(
                  width: 30,
                ),
                GestureDetector(
                    onTap: () async {
                      await showTopModalSheet<String?>(
                          context, TopSheetWidget());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        AppIcons.meetingIcon,
                        color: AppColors.backgroundColor,
                        size: 30,
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
      drawer: const DrawerWidget(),
    );
  }
}
