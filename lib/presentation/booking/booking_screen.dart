import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/car_model.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key, required this.car});

  final CarModel car;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  int _selectedDateIndex = 1;
  int _selectedTimeIndex = 2;
  int _bookingType = 0;

  final _dates = <Map<String, String>>[
    {'day': 'Mon', 'date': '14'},
    {'day': 'Tue', 'date': '15'},
    {'day': 'Wed', 'date': '16'},
    {'day': 'Thu', 'date': '17'},
    {'day': 'Fri', 'date': '18'},
    {'day': 'Sat', 'date': '19'},
    {'day': 'Sun', 'date': '20'},
  ];

  final _times = const ['09:00 AM', '10:30 AM', '12:00 PM', '02:00 PM', '04:30 PM', '06:00 PM'];
  final _bookingTypes = const ['Test Drive', 'Purchase', 'Consultation'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatPrice(double price) {
    return '\$${price.toInt().toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final value = CurvedAnimation(parent: _controller, curve: Curves.easeOut).value;
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(offset: Offset(0, 24 * (1 - value)), child: child),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      _buildCarSummary(),
                      const SizedBox(height: 28),
                      _buildBookingTypeSelector(),
                      const SizedBox(height: 28),
                      Text('Select Date', style: AppTextStyles.sectionTitle),
                      const SizedBox(height: 14),
                      _buildDateSelector(),
                      const SizedBox(height: 28),
                      Text('Select Time', style: AppTextStyles.sectionTitle),
                      const SizedBox(height: 14),
                      _buildTimeGrid(),
                      const SizedBox(height: 28),
                      _buildContactInfo(),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.grey50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
            ),
          ),
          const Spacer(),
          Text('Booking', style: AppTextStyles.sectionTitle),
          const Spacer(),
          const SizedBox(width: 42),
        ],
      ),
    );
  }

  Widget _buildCarSummary() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              widget.car.imagePath,
              width: 90,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(
                width: 90,
                height: 70,
                color: AppColors.grey100,
                child: const Icon(Icons.directions_car, color: AppColors.grey400),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.car.name, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text('${widget.car.horsepower} HP • ${widget.car.engine}', style: AppTextStyles.labelSmall),
                const SizedBox(height: 4),
                Text(_formatPrice(widget.car.price), style: AppTextStyles.priceText.copyWith(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Booking Type', style: AppTextStyles.sectionTitle),
        const SizedBox(height: 12),
        Row(
          children: List.generate(_bookingTypes.length, (i) {
            final isActive = _bookingType == i;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _bookingType = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: EdgeInsets.only(right: i < 2 ? 8 : 0),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.secondary : AppColors.grey50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      _bookingTypes[i],
                      style: AppTextStyles.chipLabel.copyWith(
                        color: isActive ? AppColors.primary : AppColors.secondary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildDateSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_dates.length, (i) {
          final isActive = _selectedDateIndex == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedDateIndex = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 56,
              margin: EdgeInsets.only(right: i < _dates.length - 1 ? 10 : 0),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: isActive ? AppColors.secondary : AppColors.grey50,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  Text(
                    _dates[i]['day']!,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: isActive ? AppColors.primary.withValues(alpha: 0.7) : AppColors.grey600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _dates[i]['date']!,
                    style: AppTextStyles.sectionTitle.copyWith(
                      color: isActive ? AppColors.primary : AppColors.secondary,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTimeGrid() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(_times.length, (i) {
        final isActive = _selectedTimeIndex == i;
        return GestureDetector(
          onTap: () => setState(() => _selectedTimeIndex = i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: isActive ? AppColors.secondary : AppColors.grey50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _times[i],
              style: AppTextStyles.chipLabel.copyWith(
                color: isActive ? AppColors.primary : AppColors.secondary,
                fontSize: 12,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contact Information', style: AppTextStyles.sectionTitle),
        const SizedBox(height: 14),
        _buildTextField('Full Name', Icons.person_outline_rounded),
        const SizedBox(height: 12),
        _buildTextField('Phone Number', Icons.phone_outlined),
        const SizedBox(height: 12),
        _buildTextField('Email Address', Icons.email_outlined),
      ],
    );
  }

  Widget _buildTextField(String hint, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.grey400),
          icon: Icon(icon, size: 20, color: AppColors.grey400),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
        style: AppTextStyles.bodyMedium,
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 14, 20, MediaQuery.of(context).padding.bottom + 14),
      decoration: BoxDecoration(
        color: AppColors.primary,
        boxShadow: [
          BoxShadow(color: AppColors.secondary.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, -4)),
        ],
      ),
      child: GestureDetector(
        onTap: _showConfirmation,
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              'Confirm Booking',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmation() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _BookingConfirmation(
        car: widget.car,
        type: _bookingTypes[_bookingType],
        date: '${_dates[_selectedDateIndex]['day']}, ${_dates[_selectedDateIndex]['date']} Apr',
        time: _times[_selectedTimeIndex],
      ),
    );
  }
}

class _BookingConfirmation extends StatefulWidget {
  const _BookingConfirmation({required this.car, required this.type, required this.date, required this.time});

  final CarModel car;
  final String type;
  final String date;
  final String time;

  @override
  State<_BookingConfirmation> createState() => _BookingConfirmationState();
}

class _BookingConfirmationState extends State<_BookingConfirmation> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _scaleAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(scale: _scaleAnim.value, child: child);
            },
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.green.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_rounded, size: 44, color: AppColors.green),
            ),
          ),
          const SizedBox(height: 20),
          Text('Booking Confirmed!', style: AppTextStyles.sectionTitle.copyWith(fontSize: 20)),
          const SizedBox(height: 8),
          Text(
            'Your ${widget.type.toLowerCase()} for\n${widget.car.name} is scheduled',
            style: AppTextStyles.bodySmall.copyWith(fontSize: 13),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.grey50,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _infoCol(Icons.calendar_today_rounded, widget.date),
                Container(width: 1, height: 30, color: AppColors.grey200),
                _infoCol(Icons.access_time_rounded, widget.time),
                Container(width: 1, height: 30, color: AppColors.grey200),
                _infoCol(Icons.directions_car_rounded, widget.type),
              ],
            ),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text('Done', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCol(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, size: 18, color: AppColors.grey600),
        const SizedBox(height: 6),
        Text(text, style: AppTextStyles.labelSmall.copyWith(fontWeight: FontWeight.w600, color: AppColors.secondary), textAlign: TextAlign.center),
      ],
    );
  }
}
