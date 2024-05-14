import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservation/models/master_schedule.dart';
import 'package:reservation/pages/client_page.dart';
import 'package:reservation/pages/provider_page.dart';

class RoleSwitcherPage extends StatelessWidget {
  const RoleSwitcherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final masterSchedule = Provider.of<MasterSchedule>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Role Switcher'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ClientPage(),
                    ),
                  );
                },
                child: const Text('Impersonate Client')),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: const Text('Choose a provider to impersonate'),
                      children: masterSchedule.providers.map<Widget>((provider) {
                        return SimpleDialogOption(
                            onPressed: () {
                              // navigate to the provider page with the selected provider
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProviderPage(currentProvider: provider),
                                ),
                              );
                            },
                            child: Material(child: ListTile(title: Text('Provider ${provider.id}'))));
                      }).toList(),
                    );
                  },
                );
              },
              child: const Text('Impersonate Provider'),
            ),
          ],
        ),
      ),
    );
  }
}
