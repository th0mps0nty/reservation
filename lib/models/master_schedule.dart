import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:reservation/models/provider.dart';
import 'package:reservation/models/timeslot.dart';

class MasterSchedule extends ChangeNotifier {
  final Map<ProviderModel, List<TimeSlot>> _masterSchedule = {
    for (final provider in fakeProviders) provider: provider.schedule,
  };

  UnmodifiableMapView<ProviderModel, List<TimeSlot>> get schedule => UnmodifiableMapView(_masterSchedule);

  get providers => _masterSchedule.keys;

  get timeSlots => _masterSchedule.values;

  void addTimeSlot(ProviderModel provider, TimeSlot timeSlot) {
    if (!_masterSchedule.containsKey(provider)) {
      _masterSchedule[provider] = [];
    }
    _masterSchedule[provider]!.add(timeSlot);
    notifyListeners();
  }

  void removeTimeSlot(ProviderModel provider, TimeSlot timeSlot) {
    _masterSchedule[provider]?.remove(timeSlot);
    notifyListeners();
  }

  void reserveTimeSlot(ProviderModel provider, TimeSlot timeSlot) {
    if (_masterSchedule[provider]?.contains(timeSlot) == true) {
      _masterSchedule[provider]!.remove(timeSlot);
      notifyListeners();
    }
  }
}

// template code
List<ProviderModel> fakeProviders = [
  ProviderModel(
    id: '1',
    schedule: [
      TimeSlot(
        start: DateTime.now().add(const Duration(hours: 1)),
        end: DateTime.now().add(const Duration(hours: 2)),
      ),
      TimeSlot(
        start: DateTime.now().add(const Duration(hours: 3)),
        end: DateTime.now().add(const Duration(hours: 4)),
      ),
    ],
  ),
  ProviderModel(
    id: '2',
    schedule: [
      TimeSlot(
        start: DateTime.now().add(const Duration(hours: 2)),
        end: DateTime.now().add(const Duration(hours: 3)),
      ),
      TimeSlot(
        start: DateTime.now().add(const Duration(hours: 4)),
        end: DateTime.now().add(const Duration(hours: 5)),
      ),
    ],
  ),
];
