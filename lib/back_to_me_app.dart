import 'package:flutter/material.dart';

class BackToMeApp extends StatelessWidget {
  const BackToMeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("Welcome"),
        ),
      ),
    );
  }
}
