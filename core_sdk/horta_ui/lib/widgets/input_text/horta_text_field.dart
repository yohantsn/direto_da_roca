import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/horta_color.dart';
import '../theme/horta_text_theme.dart';
import '../padding/horta_padding.dart';

class HortaTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final bool isObscure;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? errorMsg;
  final TextInputType? keyboardType;
  final int maxLines;
  final Widget? prefixIcon;

  const HortaTextField({
    super.key,
    required this.label,
    this.hint,
    this.isObscure = false,
    this.onChanged,
    this.controller,
    this.errorMsg,
    this.keyboardType,
    this.maxLines = 1,
    this.prefixIcon,
  });

  factory HortaTextField.name({
    Key? key,
    String? hint,
    ValueChanged<String>? onChanged,
    TextEditingController? controller,
    String? errorMsg,
    Widget? prefixIcon,
  }) {
    return HortaTextField(
      key: key,
      label: 'Nome',
      hint: hint,
      keyboardType: TextInputType.name,
      prefixIcon: prefixIcon ?? const Icon(Icons.person),
      onChanged: onChanged,
      controller: controller,
      errorMsg: errorMsg,
    );
  }

  factory HortaTextField.email({
    Key? key,
    String? hint,
    ValueChanged<String>? onChanged,
    TextEditingController? controller,
    String? errorMsg,
    Widget? prefixIcon,
  }) {
    return HortaTextField(
      key: key,
      label: 'E-mail',
      hint: hint,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: prefixIcon ?? const Icon(Icons.email),
      onChanged: onChanged,
      controller: controller,
      errorMsg: errorMsg,
    );
  }

  factory HortaTextField.phone({
    Key? key,
    String? hint,
    ValueChanged<String>? onChanged,
    TextEditingController? controller,
    String? errorMsg,
    Widget? prefixIcon,
  }) {
    return HortaTextField(
      key: key,
      label: 'Telefone',
      hint: hint,
      keyboardType: TextInputType.phone,
      prefixIcon: prefixIcon ?? const Icon(Icons.phone),
      onChanged: onChanged,
      controller: controller,
      errorMsg: errorMsg,
    );
  }

  factory HortaTextField.cep({
    Key? key,
    String? hint,
    ValueChanged<String>? onChanged,
    TextEditingController? controller,
    String? errorMsg,
    Widget? prefixIcon,
  }) {
    return HortaTextField(
      key: key,
      label: 'CEP',
      hint: hint,
      keyboardType: TextInputType.number,
      prefixIcon: prefixIcon ?? const Icon(Icons.pin_drop),
      onChanged: onChanged,
      controller: controller,
      errorMsg: errorMsg,
    );
  }

  factory HortaTextField.password({
    Key? key,
    String? hint,
    ValueChanged<String>? onChanged,
    TextEditingController? controller,
    String? errorMsg,
    Widget? prefixIcon,
  }) {
    return HortaTextField(
      key: key,
      label: 'Senha',
      hint: hint,
      isObscure: true,
      keyboardType: TextInputType.visiblePassword,
      prefixIcon: prefixIcon ?? const Icon(Icons.lock),
      onChanged: onChanged,
      controller: controller,
      errorMsg: errorMsg,
    );
  }

  @override
  State<HortaTextField> createState() => _HortaTextFieldState();
}

class _HortaTextFieldState extends State<HortaTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Padding(
      padding: HortaEdgeInsets.only(top: HortaPaddingSize.medium).value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.controller,
            obscureText: _obscureText,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: widget.hint,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.isObscure
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
              errorText: widget.errorMsg,
              labelStyle: textTheme.labelLarge,
              hintStyle: textTheme.bodyMedium,
              errorStyle: textTheme.bodySmall,
              prefixIconColor: colorScheme.onSurfaceVariant,
              suffixIconColor: colorScheme.onSurfaceVariant,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: colorScheme.outline,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: colorScheme.primary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: colorScheme.error,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: colorScheme.error,
                  width: 2,
                ),
              ),
            ),
          ),
          if (widget.errorMsg != null && widget.errorMsg!.isNotEmpty)
            Padding(
              padding: HortaEdgeInsets.only(top: HortaPaddingSize.small).value,
              child: Text(
                widget.errorMsg!,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.error,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
