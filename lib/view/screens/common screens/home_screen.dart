import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wave_learning_app/utils/colors.dart';
import 'package:wave_learning_app/utils/icons.dart';
import 'package:wave_learning_app/view/screens/mobile/mobile_login_screen.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
    final FirebaseAuth _auth = FirebaseAuth.instance;

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
                AppIcons.searchIcon,
                const SizedBox(
                  width: 30,
                ),
                GestureDetector(
                    onTap: ()async {
                     await _auth.signOut();
                     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>MobileLoginScreen()), (route) => false,);
                    },
                    child: AppIcons.uploadIcon)
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
