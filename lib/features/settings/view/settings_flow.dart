import 'package:backtome/features/settings/settings.dart';
import 'package:backtome/features/sftp/sftp.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

enum SettingsFlowState {
  settings,
  permissions,
  sftp,
  directories,
}

class SettingsFlow extends StatelessWidget {
  const SettingsFlow({Key? key}) : super(key: key);

  static MaterialPageRoute route() => MaterialPageRoute<void>(builder: (_) => const SettingsFlow());

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<SettingsFlowState>(
      state: SettingsFlowState.settings,
      onGeneratePages: (state, pages) {
        switch (state) {
          // case SettingsFlowState.permissions:
          //   return [...pages, PermissionsView.page()];
          case SettingsFlowState.sftp:
            return [...pages, SFTPView.page()];
          // case SettingsFlowState.directories:
          //   return [...pages, DirectoriesView.page()];
          case SettingsFlowState.settings:
          default:
            return [SettingsView.page()];
        }
      },
    );
  }
}
