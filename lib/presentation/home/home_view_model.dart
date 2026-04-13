import '../base/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  int _selectedBrandIndex = 0;
  int get selectedBrandIndex => _selectedBrandIndex;

  final List<String> brands = const ['BMW', 'Mercedes', 'Nissan', 'Audi', 'Toyota'];

  void selectBrand(int index) {
    _selectedBrandIndex = index;
    notifyListeners();
  }

  void toggleFavorite(int carIndex) {
    notifyListeners();
  }
}
