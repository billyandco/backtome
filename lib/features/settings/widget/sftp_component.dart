import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

import 'package:backtome/features/settings/settings.dart';
import 'package:backtome/resources/resources.dart';

class SFTPComponent extends StatelessWidget {
  const SFTPComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO to remove later
    const String ip = "192.168.1.65";
    const int port = 22;
    const String username = "pi";
    const String directory = "/home/pi";

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
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "With the power of local area network, I will connect to your IP address ",
                    style: uselessStyle,
                  ),
                  const TextSpan(
                    text: ip,
                    style: infoStyle,
                  ),
                  const TextSpan(
                    text: " from the door ",
                    style: uselessStyle,
                  ),
                  TextSpan(
                    text: port.toString(),
                    style: infoStyle,
                  ),
                  const TextSpan(
                    text: ". But don't worry, I will register my name as ",
                    style: uselessStyle,
                  ),
                  const TextSpan(
                    text: username,
                    style: infoStyle,
                  ),
                  const TextSpan(
                    text: " at the room ",
                    style: uselessStyle,
                  ),
                  const TextSpan(
                    text: directory,
                    style: infoStyle,
                  ),
                  const TextSpan(
                    text: ". See you soon.\n\nPS: Thanks for reading.",
                    style: uselessStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
