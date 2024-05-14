import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation/models/master_schedule.dart';
import 'package:reservation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MasterSchedule(),
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(2, 132, 109, 1.0)),
              useMaterial3: true,
            ),
            home: const HomePage()));
  }
}
