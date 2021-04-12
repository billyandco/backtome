import 'package:flutter/material.dart';

void closeKeyboard(BuildContext context) => FocusScope.of(context).requestFocus(FocusNode());
