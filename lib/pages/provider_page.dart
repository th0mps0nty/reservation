import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reservation/models/master_schedule.dart';
import 'package:reservation/models/provider.dart';
import 'package:reservation/models/timeslot.dart';

class ProviderPage extends StatefulWidget {
  final ProviderModel currentProvider;

  const ProviderPage({super.key, required this.currentProvider});

  @override
  // ignore: library_private_types_in_public_api
  _ProviderPageState createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  TimeOfDay? _selectedStart;
  TimeOfDay? _selectedEnd;

  @override
  Widget build(BuildContext context) {
    return Consumer<MasterSchedule>(
      builder: (context, masterSchedule, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Provider ${widget.currentProvider.id}'),
          ),
          body: ListView(
            children: [
              for (var timeSlot in widget.currentProvider.schedule)
                ListTile(
                  title: Text(
                    'Available from ${DateFormat.jm().format(timeSlot.start)} to ${DateFormat.jm().format(timeSlot.end)}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        widget.currentProvider.schedule.remove(timeSlot);
                      });
                      masterSchedule.removeTimeSlot(widget.currentProvider, timeSlot);
                    },
                  ),
                ),
              ListTile(
                title: const Text('Add new time slot'),
                subtitle: _selectedStart != null && _selectedEnd != null
                    ? Text(
                        'From ${_selectedStart!.format(context)} to ${_selectedEnd!.format(context)}',
                      )
                    : null,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: _selectedStart != null && _selectedEnd != null
                          ? () {
                              final now = DateTime.now();
                              final start = DateTime(
                                now.year,
                                now.month,
                                now.day,
                                _selectedStart!.hour,
                                _selectedStart!.minute,
                              );
                              final end = DateTime(
                                now.year,
                                now.month,
                                now.day,
                                _selectedEnd!.hour,
                                _selectedEnd!.minute,
                              );
                              final timeSlot = TimeSlot(start: start, end: end);

                              setState(() {
                                widget.currentProvider.schedule.add(timeSlot);
                                _selectedStart = null;
                                _selectedEnd = null;
                              });
                              Provider.of<MasterSchedule>(context, listen: false).addTimeSlot(widget.currentProvider, timeSlot);
                            }
                          : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.access_time),
                      onPressed: () async {
                        final selectedStart = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        final selectedEnd = await showTimePicker(
                          // ignore: use_build_context_synchronously
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (selectedStart != null && selectedEnd != null) {
                          setState(() {
                            _selectedStart = selectedStart;
                            _selectedEnd = selectedEnd;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
