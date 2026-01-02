import 'package:flutter/material.dart';
import 'package:horta_ui/horta_ui.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(colorScheme: HortaColor.light()),
      home: HortaScaffold(body: SizedBox.shrink()),
    ),
  );
}
