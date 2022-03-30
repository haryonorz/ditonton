import 'package:ditonton/common/menu_enum.dart';
import 'package:flutter/material.dart';

class DrawerNotifier extends ChangeNotifier {
  MenuItem _selectedMenu = MenuItem.Movie;
  MenuItem get selectedMenu => _selectedMenu;

  void setSelectedMenu(MenuItem menu) {
    _selectedMenu = menu;
    notifyListeners();
  }
}
