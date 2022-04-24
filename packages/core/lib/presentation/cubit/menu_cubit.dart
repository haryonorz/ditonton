import 'package:core/utils/menu_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuCubit extends Cubit<MenuItem> {
  MenuCubit() : super(MenuItem.movie);

  void setSelectedMenu(MenuItem menu) {
    emit(menu);
  }
}
