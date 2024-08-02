import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'bottom_navigation_bloc_event.dart';
part 'bottom_navigation_bloc_state.dart';

class BottomNavigationBlocBloc
    extends Bloc<BottomNavigationBlocEvent, BottomNavigationBlocState> {
  BottomNavigationBlocBloc() : super(BottomNavigationBlocInitial()) {
    on<ItemClickedEvent>(itemClickedEvent);
  }

  FutureOr<void> itemClickedEvent(
      ItemClickedEvent event, Emitter<BottomNavigationBlocState> emit) {
        emit(ItemSelectedstate(event.index));
      }
}
