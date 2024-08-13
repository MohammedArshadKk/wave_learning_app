import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view_model/blocs/check%20channel%20created%20or%20not/channel_created_or_not_bloc.dart';
import 'package:wave_learning_app/view_model/blocs/fetch%20user%20data%20bloc/fetchuserdata_bloc.dart';

profileInit(BuildContext context, String uid) {
  final isChannelCreated = context.read<ChannelCreatedOrNotBloc>();
  if (isChannelCreated.state is ChannelCreatedOrNotInitial) {
    isChannelCreated.add(ChekingChannelcreatedEvent(uid: uid));
  }

  final fetchUser = context.read<FetchuserdataBloc>();
  if (fetchUser.state is FetchuserdataInitial) {
    fetchUser.add(UserDataFetchingEvent(uid: uid));
  }
}
