part of 'bottom_navigation_bloc_bloc.dart';

@immutable
abstract class BottomNavigationBlocEvent {}

class ItemClickedEvent extends BottomNavigationBlocEvent {
 final int index;
  ItemClickedEvent(this.index);
}