import '../../data/models/car_model.dart';
import '../base/base_view_model.dart';

class CarDetailViewModel extends BaseViewModel {
  CarDetailViewModel({required CarModel car}) : _car = car;

  CarModel _car;
  CarModel get car => _car;

  int _selectedColorIndex = 0;
  int get selectedColorIndex => _selectedColorIndex;

  void selectColor(int index) {
    _selectedColorIndex = index;
    notifyListeners();
  }

  void toggleFavorite() {
    _car = _car.copyWith(isFavorite: !_car.isFavorite);
    notifyListeners();
  }
}
