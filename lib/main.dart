import 'package:flutter/material.dart';
import 'package:horta_ui/horta_ui.dart';
import 'package:iod/iod.dart';
import 'package:repository/repository.dart';

void main() async {
  IoD.register<Repository>(Repository());
  final repository = IoD.read<Repository>();
  await repository.init();
  runApp(
    MaterialApp(
      theme: ThemeData(colorScheme: HortaColor.light()),
      home: HortaScaffold(body: SizedBox.shrink()),
    ),
  );
}
