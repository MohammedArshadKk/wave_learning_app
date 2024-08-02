part of 'bottom_navigation_bloc_bloc.dart';

@immutable
abstract class BottomNavigationBlocState {}

final class BottomNavigationBlocInitial extends BottomNavigationBlocState {}

class ItemSelectedstate extends BottomNavigationBlocState {
  final int selectedIndex;

  ItemSelectedstate(this.selectedIndex);
}
