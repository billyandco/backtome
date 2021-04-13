import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

import 'package:backtome/features/settings/settings.dart';
import 'package:backtome/resources/resources.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  static MaterialPage page() => const MaterialPage<void>(child: SettingsView());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          onPressed: context.flow<SettingsFlowState>().complete,
        ),
        title: const Text('Where you set things'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: BMSizes.large),
        children: const [
          PermissionsComponent(),
          SFTPComponent(),
          DirectoriesComponent(),
        ],
      ),
    );
  }
}
