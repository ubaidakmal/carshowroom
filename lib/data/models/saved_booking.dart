class SavedBooking {
  const SavedBooking({
    required this.id,
    required this.carName,
    required this.carImagePath,
    required this.carPrice,
    required this.bookingType,
    required this.dateLabel,
    required this.time,
    required this.createdAtMs,
    this.status = 'Confirmed',
  });

  final String id;
  final String carName;
  final String carImagePath;
  final double carPrice;
  final String bookingType;
  final String dateLabel;
  final String time;
  final int createdAtMs;
  final String status;

  Map<String, dynamic> toJson() => {
        'id': id,
        'carName': carName,
        'carImagePath': carImagePath,
        'carPrice': carPrice,
        'bookingType': bookingType,
        'dateLabel': dateLabel,
        'time': time,
        'createdAtMs': createdAtMs,
        'status': status,
      };

  factory SavedBooking.fromJson(Map<String, dynamic> json) {
    return SavedBooking(
      id: json['id'] as String,
      carName: json['carName'] as String,
      carImagePath: json['carImagePath'] as String,
      carPrice: (json['carPrice'] as num).toDouble(),
      bookingType: json['bookingType'] as String,
      dateLabel: json['dateLabel'] as String,
      time: json['time'] as String,
      createdAtMs: json['createdAtMs'] as int,
      status: json['status'] as String? ?? 'Confirmed',
    );
  }
}
