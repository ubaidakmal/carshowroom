class CarModel {
  const CarModel({
    required this.name,
    required this.location,
    required this.price,
    required this.imagePath,
    this.tag,
    this.isFavorite = false,
    this.engine = '3.0L Twin-Turbo I6',
    this.horsepower = 473,
    this.topSpeed = 250,
    this.acceleration = 3.8,
    this.fuelType = 'Petrol',
    this.transmission = 'Automatic',
    this.year = 2025,
    this.description = 'Experience unparalleled luxury and performance with cutting-edge technology, premium craftsmanship, and exhilarating driving dynamics.',
  });

  final String name;
  final String location;
  final double price;
  final String imagePath;
  final String? tag;
  final bool isFavorite;

  final String engine;
  final int horsepower;
  final int topSpeed;
  final double acceleration;
  final String fuelType;
  final String transmission;
  final int year;
  final String description;

  CarModel copyWith({bool? isFavorite}) {
    return CarModel(
      name: name,
      location: location,
      price: price,
      imagePath: imagePath,
      tag: tag,
      isFavorite: isFavorite ?? this.isFavorite,
      engine: engine,
      horsepower: horsepower,
      topSpeed: topSpeed,
      acceleration: acceleration,
      fuelType: fuelType,
      transmission: transmission,
      year: year,
      description: description,
    );
  }
}
