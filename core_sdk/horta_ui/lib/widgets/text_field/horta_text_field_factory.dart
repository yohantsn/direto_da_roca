import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension HortaTextFieldExtensions on HortaTextField {
  static HortaTextField name({
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
      keyboardType: TextInputType.name,
      prefixIcon: const Icon(Icons.person),
    );
  }

  static HortaTextField email({
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
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.email),
    );
  }

  static HortaTextField phone({
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
      keyboardType: TextInputType.phone,
      prefixIcon: const Icon(Icons.phone),
    );
  }

  static HortaTextField cep({
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
      keyboardType: TextInputType.number,
      prefixIcon: const Icon(Icons.location_on),
    );
  }

  static HortaTextField password({
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
      keyboardType: TextInputType.visiblePassword,
      isObscure: true,
      prefixIcon: const Icon(Icons.lock),
      suffixIcon: const Icon(Icons.visibility),
    );
  }
}
