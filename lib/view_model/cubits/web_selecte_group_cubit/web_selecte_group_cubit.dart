import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wave_learning_app/model/channel_model.dart';

part 'web_selecte_group_state.dart';

class WebSelecteGroupCubit extends Cubit<WebSelecteGroupState> {
  WebSelecteGroupCubit() : super(WebSelecteGroupInitial());
  selectChannel(ChannelModel selectedChannel) {
    emit(GroupSelectedState(selectedChannel: selectedChannel));
  }
}
