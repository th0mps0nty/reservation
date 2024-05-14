import 'package:reservation/models/client.dart';
import 'package:reservation/models/provider.dart';
import 'package:reservation/models/timeslot.dart';

// Represents a reservation made by a client for a specific time slot with a provider.
class Reservation {
  final String id;
  final ProviderModel provider;
  final Client client;
  final TimeSlot timeSlot;
  DateTime? reservationTime;
  bool confirmed = false;

  Reservation({required this.id, required this.provider, required this.client, required this.timeSlot});

  void reserve() {
    reservationTime = DateTime.now();
  }

  void confirm() {
    if (reservationTime != null && DateTime.now().difference(reservationTime!).inMinutes <= 30) {
      confirmed = true;
    } else {
      throw Exception('Reservation expired or not made yet');
    }
  }

  bool isExpired() {
    if (reservationTime == null) {
      return false;
    }
    return DateTime.now().difference(reservationTime!).inMinutes > 30;
  }

  bool isMadeInAdvance() {
    if (reservationTime == null) {
      return false;
    }
    return timeSlot.start.difference(reservationTime!).inHours >= 24;
  }
}
