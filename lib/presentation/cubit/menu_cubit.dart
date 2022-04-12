import 'package:ditonton/common/menu_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuCubit extends Cubit<MenuItem> {
  MenuCubit() : super(MenuItem.Movie);

  void setSelectedMenu(MenuItem menu) {
    emit(menu);
  }
}
