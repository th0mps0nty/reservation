// Represents a provider who offers time slots for reservations.
import 'package:reservation/models/reservation.dart';
import 'package:reservation/models/timeslot.dart';

class ProviderModel {
  final String id;
  final List<TimeSlot> _schedule = [];

  ProviderModel({required this.id, List<TimeSlot>? schedule, List<Reservation>? reservations}) {
    if (schedule != null) {
      _schedule.addAll(schedule);
    }
    if (reservations != null) {
      for (final reservation in reservations) {
        _schedule.remove(reservation.timeSlot);
      }
    }
  }

  List<TimeSlot> get schedule => _schedule;

  void addTimeSlot(TimeSlot timeSlot) {
    _schedule.add(timeSlot);
  }

  void removeTimeSlot(TimeSlot timeSlot) {
    _schedule.remove(timeSlot);
  }
}
