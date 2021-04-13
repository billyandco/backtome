import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'features/home/home.dart';
import 'providers/hive/hive.dart';
import 'resources/resources.dart';

class BackToMeApp extends StatefulWidget {
  const BackToMeApp({Key? key}) : super(key: key);

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter<Settings>(SettingsAdapter());
  }

  @override
  _BackToMeAppState createState() => _BackToMeAppState();
}

class _BackToMeAppState extends State<BackToMeApp> {
  @override
  void initState() {
    super.initState();
    Hive.openBox<Settings>(LocalHiveBox.settings.toString());
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            fontSize: BMSizes.large,
            fontWeight: FontWeight.w400,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(BMSizes.small),
          ),
        ),
      ),
      home: const HomeView(),
    );
  }
}
