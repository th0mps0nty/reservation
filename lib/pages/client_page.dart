import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation/models/master_schedule.dart';
import 'package:intl/intl.dart';

class ClientPage extends StatelessWidget {
  const ClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    final masterSchedule = Provider.of<MasterSchedule>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Page'),
      ),
      body: ListView.builder(
        itemCount: masterSchedule.providers.length,
        itemBuilder: (context, index) {
          final provider = masterSchedule.schedule.keys.elementAt(index);
          final providerSchedule = masterSchedule.schedule[provider]!;
          return ExpansionTile(
            title: Text('Provider ${provider.id}'),
            children: providerSchedule.map((timeSlot) {
              final start = DateFormat.jm().format(timeSlot.start);
              final end = DateFormat.jm().format(timeSlot.end);
              return ListTile(
                  title: Text('Available from $start to $end'),
                  onTap: () async {
                    final confirm = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirm Reservation'),
                          content: const Text('Are you sure you want to reserve this time slot?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('Confirm'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Cancel'),
                            ),
                          ],
                        );
                      },
                    );
                    if (confirm == true) {
                      masterSchedule.removeTimeSlot(provider, timeSlot);
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Reserved time slot from $start to $end')),
                      );
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Reservation cancelled')),
                      );
                    }
                  });
            }).toList(),
          );
        },
      ),
    );
  }
}
