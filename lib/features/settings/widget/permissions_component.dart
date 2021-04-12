import 'package:backtome/resources/resources.dart';
import 'package:flutter/material.dart';

class PermissionsComponent extends StatelessWidget {
  const PermissionsComponent();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(BMSizes.large),
      child: Material(
        color: Colors.blue.withOpacity(0.15),
        child: InkWell(
          onTap: () {
            // TODO handle permissions
          },
          child: Padding(
            padding: const EdgeInsets.all(BMSizes.large),
            child: Row(
              children: const [
                Icon(Icons.lock_open),
                SizedBox(width: BMSizes.large),
                Expanded(
                  child: Text('To make sure to granted all needed persmissions to enable backup'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
