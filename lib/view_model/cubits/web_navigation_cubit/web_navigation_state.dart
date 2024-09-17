part of 'web_navigation_cubit.dart';

@immutable
abstract class WebNavigationState {}

final class WebNavigationInitial extends WebNavigationState {}

class WebItemSelectedstate extends WebNavigationState {
  final int index;

  WebItemSelectedstate({required this.index});
  
}
