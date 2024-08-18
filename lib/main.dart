import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/firebase_options.dart';
import 'package:wave_learning_app/view_model/blocs/authentication%20bloc/authentication_bloc.dart';
import 'package:wave_learning_app/view_model/blocs/channel%20createtion%20bloc/channel_creation_bloc.dart';
import 'package:wave_learning_app/view_model/blocs/check%20channel%20created%20or%20not/channel_created_or_not_bloc.dart';
import 'package:wave_learning_app/view_model/blocs/fetch%20user%20data%20bloc/fetchuserdata_bloc.dart';
import 'package:wave_learning_app/view_model/blocs/get%20channel%20details%20bloc/get_channel_details_bloc.dart';
import 'package:wave_learning_app/view/screens/common%20screens/start_screen.dart';
import 'package:wave_learning_app/view_model/blocs/video_uploading_bloc/video_uploading_bloc.dart';
import 'package:wave_learning_app/view_model/functions/video_upload_functions/callback_dispatcher.dart';
import 'package:workmanager/workmanager.dart';
import 'view_model/blocs/bottom navigation bloc/bottom_navigation_bloc_bloc.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavigationBlocBloc(),
        ),
        BlocProvider(
          create: (context) => AuthenticationBloc(),
        ),
        BlocProvider(
          create: (context) => FetchuserdataBloc(),
        ),
        BlocProvider(
          create: (context) => ChannelCreationBloc(),
        ),
        BlocProvider(
          create: (context) => ChannelCreatedOrNotBloc(),
        ),
        BlocProvider(
          create: (context) => GetChannelDetailsBloc(),
        ),
        BlocProvider(
          create: (context) => VideoUploadingBloc(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StartScreen(),
      ),
    );
  }
}
