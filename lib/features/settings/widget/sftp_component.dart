import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

import 'package:backtome/features/settings/settings.dart';

class SFTPComponent extends StatelessWidget {
  const SFTPComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            context.flow<SettingsFlowState>().update((_) => SettingsFlowState.sftp);
          },
          child: const Text('SFTP'),
        ),
      ],
    );
  }
}
