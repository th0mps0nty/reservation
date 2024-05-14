import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation/models/master_schedule.dart';
import 'package:reservation/models/provider.dart';
import 'package:reservation/models/timeslot.dart';
import 'package:reservation/pages/provider_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ProviderPage shows available time slots', (WidgetTester tester) async {
    // Arrange
    final provider = ProviderModel(id: '1', schedule: [
      TimeSlot(start: DateTime(2022, 1, 1, 9, 0), end: DateTime(2022, 1, 1, 10, 0)),
      TimeSlot(start: DateTime(2022, 1, 1, 10, 0), end: DateTime(2022, 1, 1, 11, 0)),
    ]);
    final masterSchedule = MasterSchedule();

    // Act
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MasterSchedule>.value(value: masterSchedule),
        ],
        child: MaterialApp(
          home: ProviderPage(currentProvider: provider),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Available from 9:00 AM to 10:00 AM'), findsOneWidget);
    expect(find.text('Available from 10:00 AM to 11:00 AM'), findsOneWidget);
  });
}
