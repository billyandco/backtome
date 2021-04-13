import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:backtome/resources/resources.dart';

class PermissionsComponent extends StatefulWidget {
  const PermissionsComponent();

  @override
  _PermissionsComponentState createState() => _PermissionsComponentState();
}

class _PermissionsComponentState extends State<PermissionsComponent> {
  bool hasAllPermission = false;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final bool granted = await Permission.storage.isGranted;
    setState(() {
      hasAllPermission = granted;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (hasAllPermission) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(top: BMSizes.large),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(BMSizes.large),
        child: Material(
          color: Colors.blue.withOpacity(0.15),
          child: InkWell(
            onTap: () async {
              if (!await Permission.storage.isGranted) {
                final granted = await Permission.storage.request().isGranted;
                setState(() {
                  hasAllPermission = granted;
                });
              }
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
      ),
    );
  }
}
