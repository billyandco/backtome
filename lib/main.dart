import 'package:backtome/back_to_me_app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await BackToMeApp.init();
  runApp(const BackToMeApp());
}
