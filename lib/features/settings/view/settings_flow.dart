import 'package:backtome/features/directory/directory.dart';
import 'package:backtome/features/settings/settings.dart';
import 'package:backtome/features/sftp/sftp.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SFTPRepository>(create: (_) => const SFTPRepository()),
        RepositoryProvider<SettingsRepository>(create: (_) => const SettingsRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsCubit>(
            create: (context) => SettingsCubit(
              settingsRepository: context.read<SettingsRepository>(),
            ),
          ),
        ],
        child: const _SettingsFlow(),
      ),
    );
  }
}

class _SettingsFlow extends StatelessWidget {
  const _SettingsFlow({Key? key}) : super(key: key);

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
          case SettingsFlowState.directories:
            return [...pages, DirectoriesView.page()];
          case SettingsFlowState.settings:
          default:
            return [SettingsView.page()];
        }
      },
    );
  }
}
