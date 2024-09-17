import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'web_navigation_state.dart';

class WebNavigationCubit extends Cubit<WebNavigationState> {
  WebNavigationCubit() : super(WebNavigationInitial());
  itemSelected(int index){
   emit(WebItemSelectedstate(index: index));
  }
}

