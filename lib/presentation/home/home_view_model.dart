import '../../core/constants/app_assets.dart';
import '../../data/models/car_model.dart';
import '../base/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel() {
    _cars = List<CarModel>.from(_initialCars);
  }

  int _selectedBrandIndex = 0;
  int get selectedBrandIndex => _selectedBrandIndex;

  final List<String> brands = const ['BMW', 'Mercedes', 'Nissan', 'Audi', 'Toyota'];

  late List<CarModel> _cars;
  List<CarModel> get cars => _cars;

  void selectBrand(int index) {
    _selectedBrandIndex = index;
    notifyListeners();
  }

  void toggleFavorite(int index) {
    _cars[index] = _cars[index].copyWith(isFavorite: !_cars[index].isFavorite);
    notifyListeners();
  }

  static const _initialCars = [
    CarModel(
      name: 'BMW Luxury Drive',
      location: 'BMW Luxury Drive',
      price: 30980,
      imagePath: AppAssets.onboardImage1,
      tag: 'Sale',
      isFavorite: true,
      engine: '2.0L Twin-Power Turbo I4',
      horsepower: 382,
      topSpeed: 250,
      acceleration: 4.1,
      transmission: '8-Speed Automatic',
      year: 2025,
      description: 'A perfect blend of luxury and sportiness. The BMW Luxury Drive offers responsive handling, premium interiors, and advanced driver-assistance technology.',
    ),
    CarModel(
      name: 'Mercedes AMG GT',
      location: 'Mercedes Showroom',
      price: 45500,
      imagePath: AppAssets.car1,
      tag: 'New',
      engine: '4.0L V8 Biturbo',
      horsepower: 577,
      topSpeed: 315,
      acceleration: 3.1,
      transmission: '9-Speed AMG Speedshift',
      year: 2025,
      description: 'Handcrafted AMG performance meets breathtaking design. The AMG GT delivers raw power with refined elegance for the ultimate driving experience.',
    ),
    CarModel(
      name: 'BMW M5 Competition',
      location: 'BMW Motorrad',
      price: 52990,
      imagePath: AppAssets.onboardImage2,
      tag: 'Sale',
      engine: '4.4L Twin-Turbo V8',
      horsepower: 617,
      topSpeed: 305,
      acceleration: 3.3,
      transmission: '8-Speed M Steptronic',
      year: 2024,
      description: 'The most powerful M5 ever built. Combines supercar performance with executive sedan comfort for those who demand everything.',
    ),
    CarModel(
      name: 'Nissan GT-R Nismo',
      location: 'Nissan Premium',
      price: 61400,
      imagePath: AppAssets.car2,
      engine: '3.8L Twin-Turbo V6',
      horsepower: 600,
      topSpeed: 330,
      acceleration: 2.5,
      fuelType: 'Petrol',
      transmission: '6-Speed Dual Clutch',
      year: 2024,
      description: 'Born on the track, perfected for the road. The GT-R Nismo is a hand-assembled masterpiece of Japanese engineering and racing heritage.',
    ),
    CarModel(
      name: 'BMW X7 xDrive',
      location: 'BMW Elite Motors',
      price: 75800,
      imagePath: AppAssets.car4,
      tag: 'Hot',
      isFavorite: true,
      engine: '3.0L Inline-6 Turbo',
      horsepower: 375,
      topSpeed: 245,
      acceleration: 5.8,
      transmission: '8-Speed Automatic',
      year: 2025,
      description: 'The flagship BMW SUV redefines luxury travel. Spacious three-row seating, panoramic views, and commanding road presence for the whole family.',
    ),
    CarModel(
      name: 'Audi RS7 Sportback',
      location: 'Audi Centre',
      price: 68900,
      imagePath: AppAssets.car3,
      tag: 'New',
      engine: '4.0L TFSI V8 Biturbo',
      horsepower: 591,
      topSpeed: 305,
      acceleration: 3.6,
      transmission: '8-Speed Tiptronic',
      year: 2025,
      description: 'Where gran turismo meets supercar. The RS7 Sportback combines striking fastback design with quattro all-wheel-drive dominance.',
    ),
  ];
}
