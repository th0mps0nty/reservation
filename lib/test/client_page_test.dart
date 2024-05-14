import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:reservation/models/master_schedule.dart';
import 'package:reservation/models/provider.dart';
import 'package:reservation/models/timeslot.dart';
import 'package:reservation/pages/client_page.dart';

void main() {
  group('ClientPage', () {
    final provider = ProviderModel(id: '1', schedule: [
      TimeSlot(start: DateTime(2022, 1, 1, 9, 0), end: DateTime(2022, 1, 1, 10, 0)),
      TimeSlot(start: DateTime(2022, 1, 1, 10, 0), end: DateTime(2022, 1, 1, 11, 0)),
    ]);
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (_) => MasterSchedule(),
            child: const ClientPage(),
          ),
        ),
      );

      expect(find.text('Client Page'), findsOneWidget);
      expect(find.byType(ExpansionTile), findsNWidgets(2)); // Assuming there are 3 providers in the master schedule
    });

    testWidgets('displays available time slots', (WidgetTester tester) async {
      final masterSchedule = MasterSchedule();
      masterSchedule.addTimeSlot(provider, TimeSlot(start: DateTime(2022, 1, 1, 9, 0), end: DateTime(2022, 1, 1, 10, 0)));

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: masterSchedule,
            child: const ClientPage(),
          ),
        ),
      );

      expect(find.text('Available from 9:00 AM to 10:00 AM'), findsOneWidget);
    });

    testWidgets('confirms reservation and removes time slot', (WidgetTester tester) async {
      final masterSchedule = MasterSchedule();
      masterSchedule.addTimeSlot(provider, TimeSlot(start: DateTime(2022, 1, 1, 9, 0), end: DateTime(2022, 1, 1, 10, 0)));

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: masterSchedule,
            child: const ClientPage(),
          ),
        ),
      );

      await tester.tap(find.text('Available from 9:00 AM to 10:00 AM'));
      await tester.pumpAndSettle();

      expect(find.text('Confirm Reservation'), findsOneWidget);
      expect(find.text('Are you sure you want to reserve this time slot?'), findsOneWidget);

      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();

      expect(masterSchedule.schedule[provider], isEmpty);
      expect(find.text('Reserved time slot from 9:00 AM to 10:00 AM'), findsOneWidget);
    });

    testWidgets('cancels reservation', (WidgetTester tester) async {
      final masterSchedule = MasterSchedule();
      masterSchedule.addTimeSlot(provider, TimeSlot(start: DateTime(2022, 1, 1, 9, 0), end: DateTime(2022, 1, 1, 10, 0)));

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: masterSchedule,
            child: const ClientPage(),
          ),
        ),
      );

      await tester.tap(find.text('Available from 9:00 AM to 10:00 AM'));
      await tester.pumpAndSettle();

      expect(find.text('Confirm Reservation'), findsOneWidget);
      expect(find.text('Are you sure you want to reserve this time slot?'), findsOneWidget);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(masterSchedule.schedule[provider], isNotEmpty);
      expect(find.text('Reservation cancelled'), findsOneWidget);
    });
  });
}
