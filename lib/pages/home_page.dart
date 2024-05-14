import 'package:flutter/material.dart';
import 'package:reservation/pages/role_switcher_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/henry1.png', height: 50),
      ),
      body: Container(
        alignment: Alignment.center,
        color: const Color.fromRGBO(2, 132, 109, 1.0),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.asset(
                'assets/henry1.png',
                fit: BoxFit.cover,
              ),
              const Text('Tap the button to continue to the role switcher.'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RoleSwitcherPage(),
            ),
          );
        },
        child: const Icon(Icons.arrow_right_alt_rounded),
      ),
    );
  }
}
