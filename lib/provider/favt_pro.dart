import 'package:flutter/foundation.dart';

class FavoriteProviderClass with ChangeNotifier {
  List<int> _SelectedItem = [];
  List<int> get SelectedItem => _SelectedItem;

  void addItem(int value) {
    _SelectedItem.add(value);
    notifyListeners();
  }

  void removeItem(int value) {
    _SelectedItem.remove(value);
    notifyListeners();
  }
}
