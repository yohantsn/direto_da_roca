import 'package:aiuri_sdk/aiuri_sdk.dart';
import 'package:direto_da_roca/config/aiuri_config_generated.dart';
import 'package:flutter/material.dart';
import 'package:horta_ui/horta_ui.dart';
import 'package:iod/iod.dart';

void main() async {
  // IoD.register<AiuriSDK>(AiuriSDK());
  // final repository = IoD.read<AiuriSDK>();
  // await repository.init(aiuriConfig);
  runApp(
    MaterialApp(
      theme: HortaTheme.light,
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Direto da Roca')),
          body: HortaPadding(
            padding: .all(.medium),
            child: Center(
              child: HortaInputText.email(
                context,
                hintText: 'josedasilva@gmail.com',
                labelText: "Email",
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
