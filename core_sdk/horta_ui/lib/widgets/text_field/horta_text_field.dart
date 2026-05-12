import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:core_sdk/horta_ui/theme/horta_color.dart';
import 'package:core_sdk/horta_ui/theme/horta_text_theme.dart';
import 'package:core_sdk/horta_ui/widgets/padding/horta_padding.dart';

class HortaTextField extends StatefulWidget {
  const HortaTextField({
    super.key,
    required this.label,
    this.hint,
    this.isObscure = false,
    this.onChanged,
    this.controller,
    this.errorMsg,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
  });

  final String label;
  final String? hint;
  final bool isObscure;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? errorMsg;
  final TextInputType keyboardType;
  final int maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  State<HortaTextField> createState() => _HortaTextFieldState();
}

class _HortaTextFieldState extends State<HortaTextField> {
  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: HortaPaddingSize.small.value,
            vertical: HortaPaddingSize.medium.value,
          ),
          decoration: BoxDecoration(
            color: widget.errorMsg != null
                ? colorScheme.errorContainer.withOpacity(0.1)
                : colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.errorMsg != null
                  ? colorScheme.error
                  : colorScheme.outline,
              width: 1,
            ),
          ),
          child: TextField(
            controller: widget.controller,
            onChanged: widget.onChanged,
            obscureText: widget.isObscure ? _obscureText : false,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: widget.hint,
              labelStyle: textTheme.labelSmall.copyWith(
                color: widget.errorMsg != null
                    ? colorScheme.error
                    : colorScheme.onSurfaceVariant,
              ),
              hintStyle: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant.withOpacity(0.5),
              ),
              errorText: widget.errorMsg,
              errorStyle: textTheme.bodySmall?.copyWith(
                color: colorScheme.error,
              ),
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: HortaPaddingSize.small.value),
                      child: widget.prefixIcon,
                    )
                  : null,
              suffixIcon: widget.isObscure && widget.suffixIcon == null
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : widget.suffixIcon,
            ),
          ),
        ),
        if (widget.errorMsg != null)
          Padding(
            padding: const EdgeInsets.only(top: HortaPaddingSize.small.value),
            child: Text(
              widget.errorMsg!,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }
}
