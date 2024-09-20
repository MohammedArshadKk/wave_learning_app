import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wave_learning_app/firebase_options.dart';
import 'package:wave_learning_app/services/repositories/notification/notification_service.dart';
import 'package:wave_learning_app/view_model/blocs/authentication%20bloc/authentication_bloc.dart';
import 'package:wave_learning_app/view_model/blocs/channel%20createtion%20bloc/channel_creation_bloc.dart';
import 'package:wave_learning_app/view_model/blocs/check%20channel%20created%20or%20not/channel_created_or_not_bloc.dart';
import 'package:wave_learning_app/view_model/cubits/background_service_cubit/video_upload_background_cubit.dart';
import 'package:wave_learning_app/view_model/blocs/fetch%20user%20data%20bloc/fetchuserdata_bloc.dart';
import 'package:wave_learning_app/view_model/blocs/get_channel_details_bloc/get_channel_details_bloc.dart';
import 'package:wave_learning_app/view/screens/common_screens/start_screen.dart';
import 'package:wave_learning_app/view_model/blocs/video_uploading_bloc/video_uploading_bloc.dart';
import 'package:wave_learning_app/view_model/cubits/chat_bot/chat_bot_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/chat_cubit/chat_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/create_meeting_cubit/create_meeting_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/create_playlist_cubit/create_playlist_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/fetch_user_videos_cubit/fetch_user_videos_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/get_all_videos%20cubit/get_all_videos_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/get_latest_joined_channel_videos_cubit/get_latest_joined_channel_videos_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/history_cubit/history_cubit.dart';
import 'package:wave_learning_app/view_model/cubits/web_navigation_cubit/web_navigation_cubit.dart';
import 'package:wave_learning_app/view_model/functions/video_upload_functions/initialize_background_service.dart';
import 'package:workmanager/workmanager.dart';
import 'view_model/blocs/bottom navigation bloc/bottom_navigation_bloc_bloc.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Workmanager().initialize(callbackDispatcher);
  await NotificationService().initNotification();
  await dotenv.load(fileName: ".env");
  runApp(MyApp(
    geminiApiKey: dotenv.env['gemini_api_key'],
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.geminiApiKey});
  final String? geminiApiKey;
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
        BlocProvider(
          create: (context) => VideoUploadBackgroundCubit(),
        ),
        BlocProvider(
          create: (context) => FetchUserVideosCubit(),
        ),
        BlocProvider(
          create: (context) => GetAllVideosCubit(),
        ),
        BlocProvider(
          create: (context) => CreatePlaylistCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
        BlocProvider(
          create: (context) => HistoryCubit(),
        ),
        BlocProvider(
          create: (context) => ChatBotCubit(apiKey: geminiApiKey),
        ),
        BlocProvider(
          create: (context) => CreateMeetingCubit(),
        ),
        BlocProvider(
          create: (context) => WebNavigationCubit(),
        ),
        BlocProvider(
          create: (context) => GetLatestJoinedChannelVideosCubit(),
        ),
        
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StartScreen(
          apiKey: geminiApiKey,
        ),
      ),
    );
  }
}
