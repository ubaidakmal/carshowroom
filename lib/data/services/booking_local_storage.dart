import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/saved_booking.dart';

/// Persists confirmed bookings on device ([SharedPreferences]).
class BookingLocalStorage extends ChangeNotifier {
  BookingLocalStorage._();

  static const _key = 'car_showroom_saved_bookings_v1';
  static final BookingLocalStorage instance = BookingLocalStorage._();

  Future<List<SavedBooking>> loadBookings() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null || raw.isEmpty) return [];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => SavedBooking.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList()
        ..sort((a, b) => b.createdAtMs.compareTo(a.createdAtMs));
    } catch (_) {
      return [];
    }
  }

  Future<void> addBooking(SavedBooking booking) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = await loadBookings();
    final updated = [booking, ...existing];
    final encoded = jsonEncode(updated.map((b) => b.toJson()).toList());
    await prefs.setString(_key, encoded);
    notifyListeners();
  }

  Future<void> removeBooking(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = await loadBookings();
    final updated = existing.where((b) => b.id != id).toList();
    final encoded = jsonEncode(updated.map((b) => b.toJson()).toList());
    await prefs.setString(_key, encoded);
    notifyListeners();
  }

  Future<int> count() async {
    final list = await loadBookings();
    return list.length;
  }
}
