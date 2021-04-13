import 'package:flutter/material.dart';

import 'package:backtome/resources/resources.dart';

class ComponentHeader extends StatelessWidget {
  const ComponentHeader({
    Key? key,
    required this.title,
    required this.icon,
    required this.onEdit,
  }) : super(key: key);

  final String title;
  final Icon icon;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: BMSizes.xLarge,
            ),
          ),
        ),
        IconButton(
          onPressed: onEdit,
          icon: icon,
        ),
      ],
    );
  }
}
