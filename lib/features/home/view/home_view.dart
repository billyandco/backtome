import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:backtome/features/settings/settings.dart';
import 'package:backtome/features/sftp/sftp.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SFTPRepository>(create: (_) => const SFTPRepository()),
        RepositoryProvider<SettingsRepository>(create: (_) => const SettingsRepository()),
      ],
      // child: MultiBlocProvider(providers: []),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BackToMe'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.sports_bar_outlined),
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
