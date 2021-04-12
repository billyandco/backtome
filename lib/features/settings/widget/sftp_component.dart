import 'package:backtome/features/sftp/sftp.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

import 'package:backtome/features/settings/settings.dart';
import 'package:backtome/resources/resources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SFTPComponent extends StatelessWidget {
  const SFTPComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const uselessStyle = TextStyle(
      color: Color.fromRGBO(200, 200, 200, 1),
      fontWeight: FontWeight.w300,
    );
    const infoStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: BMSizes.large,
    );

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(BMSizes.large),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 2,
              right: 2,
              left: BMSizes.large,
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    "SFTP story",
                    style: TextStyle(
                      fontSize: BMSizes.xLarge,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.flow<SettingsFlowState>().update((_) => SettingsFlowState.sftp);
                  },
                  icon: const Icon(Icons.edit_outlined),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(BMSizes.large, BMSizes.small, BMSizes.large, BMSizes.large),
            child: BlocBuilder<SFTPSettingsCubit, Parameter>(builder: (context, state) {
              if (state == Parameter.empty) {
                return const Text("I have nothing to tell you");
              }

              return RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "With the power of local area network, I will connect to your IP address ",
                      style: uselessStyle,
                    ),
                    TextSpan(
                      text: state.ip,
                      style: infoStyle,
                    ),
                    const TextSpan(
                      text: " from the door ",
                      style: uselessStyle,
                    ),
                    const TextSpan(
                      text: "22",
                      style: infoStyle,
                    ),
                    const TextSpan(
                      text: ". But don't worry, I will register my name as ",
                      style: uselessStyle,
                    ),
                    TextSpan(
                      text: state.username,
                      style: infoStyle,
                    ),
                    const TextSpan(
                      text: " at the room ",
                      style: uselessStyle,
                    ),
                    TextSpan(
                      text: state.directory,
                      style: infoStyle,
                    ),
                    const TextSpan(
                      text: ". See you soon.\n\nPS: Thanks for reading.",
                      style: uselessStyle,
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
