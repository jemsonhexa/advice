import 'package:flutter/material.dart';

class AdviceField extends StatelessWidget {
  final String advice;
  const AdviceField({super.key, required this.advice});

  @override
  Widget build(BuildContext context) {
    final themData = Theme.of(context);
    return Material(
      elevation: 20,
      borderRadius: BorderRadius.circular(10),
      color: themData.colorScheme.onPrimary,
      child: Container(
        decoration: BoxDecoration(color: themData.colorScheme.onPrimary),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(advice, style: themData.textTheme.bodyLarge),
        ),
      ),
    );
  }
}
