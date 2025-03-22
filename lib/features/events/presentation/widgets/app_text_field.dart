import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? readOnly;
  final VoidCallback onTap;
  final VoidCallback? onSuffixTapped;

  const AppTextField({
    required this.hintText,
    required this.onTap,
    required this.controller,
    this.onSuffixTapped,
    this.readOnly,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final hasText = value.text.isNotEmpty;
        return TextField(
          onTap: onTap,
          readOnly: readOnly ?? true,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: hasText
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.clear();
                      onSuffixTapped?.call();
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    );
  }
}
