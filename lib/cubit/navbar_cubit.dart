import 'package:bloc/bloc.dart';

class NavigationChange extends Cubit<int> {
  NavigationChange() : super(0);

  void changeNavigation(int index) {
    emit(index);
  }
}
