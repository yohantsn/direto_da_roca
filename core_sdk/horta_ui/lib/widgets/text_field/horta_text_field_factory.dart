import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:core_sdk/horta_ui/widgets/text_field/horta_text_field.dart';
import 'package:core_sdk/horta_ui/widgets/icons/horta_icons.dart';

class HortaTextField {
  factory HortaTextField.name({
    Key? key,
    String? hint,
    ValueChanged<String>? onChanged,
    TextEditingController? controller,
    String? errorMsg,
  }) {
    return HortaTextField(
      key: key,
      label: 'Nome',
      hint: hint,
      onChanged: onChanged,
      controller: controller,
      errorMsg: errorMsg,
      keyboardType: TextInputType.name,
      prefixIcon: const Icon(HortaIcons.person),
    );
  }

  factory HortaTextField.email({
    Key? key,
    String? hint,
    ValueChanged<String>? onChanged,
    TextEditingController? controller,
    String? errorMsg,
  }) {
    return HortaTextField(
      key: key,
      label: 'E-mail',
      hint: hint,
      onChanged: onChanged,
      controller: controller,
      errorMsg: errorMsg,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(HortaIcons.email),
    );
  }

  factory HortaTextField.phone({
    Key? key,
    String? hint,
    ValueChanged<String>? onChanged,
    TextEditingController? controller,
    String? errorMsg,
  }) {
    return HortaTextField(
      key: key,
      label: 'Telefone',
      hint: hint,
      onChanged: onChanged,
      controller: controller,
      errorMsg: errorMsg,
      keyboardType: TextInputType.phone,
      prefixIcon: const Icon(HortaIcons.phone),
    );
  }

  factory HortaTextField.cep({
    Key? key,
    String? hint,
    ValueChanged<String>? onChanged,
    TextEditingController? controller,
    String? errorMsg,
  }) {
    return HortaTextField(
      key: key,
      label: 'CEP',
      hint: hint,
      onChanged: onChanged,
      controller: controller,
      errorMsg: errorMsg,
      keyboardType: TextInputType.number,
      prefixIcon: const Icon(HortaIcons.location_on),
    );
  }

  factory HortaTextField.password({
    Key? key,
    String? hint,
    ValueChanged<String>? onChanged,
    TextEditingController? controller,
    String? errorMsg,
  }) {
    return HortaTextField(
      key: key,
      label: 'Senha',
      hint: hint,
      onChanged: onChanged,
      controller: controller,
      errorMsg: errorMsg,
      keyboardType: TextInputType.visiblePassword,
      isObscure: true,
      prefixIcon: const Icon(HortaIcons.lock),
      suffixIcon: const Icon(HortaIcons.visibility),
    );
  }
}
