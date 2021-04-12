import 'package:backtome/features/settings/settings.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BackToMe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.storage_outlined),
            onPressed: () {
              Navigator.of(context).push<void>(SettingsFlow.route());
            },
          ),
        ],
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Home'),
        ),
      ),
    );
  }
}
