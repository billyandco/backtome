import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:backtome/features/settings/settings.dart';
import 'package:backtome/resources/resources.dart';
import 'package:permission_handler/permission_handler.dart';

class DirectoriesComponent extends StatelessWidget {
  const DirectoriesComponent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: BMSizes.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ComponentHeader(
            title: "Folders classified",
            icon: const Icon(Icons.folder_open_outlined),
            onEdit: () async {
              if (await Permission.storage.isGranted) {
                context.flow<SettingsFlowState>().update((_) => SettingsFlowState.directories);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Make sure to granted storage permissions.',
                    ),
                  ),
                );
              }
            },
          ),
          BlocBuilder<SettingsCubit, Settings>(
            builder: (context, state) {
              if (state.directories.isEmpty) {
                return const Text(
                  'Give me something do to...',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                );
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: state.directories.map((e) => Text(e)).toList(),
              );
            },
          )
        ],
      ),
    );
  }
}
