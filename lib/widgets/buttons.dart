import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';

class PrimaryButton extends ConsumerWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? width;
  final bool disabled;

  const PrimaryButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: disabled || isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(label),
      ),
    );
  }
}

class SecondaryButton extends ConsumerWidget {
  final String label;
  final VoidCallback onPressed;
  final double? width;
  final bool disabled;

  const SecondaryButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.width,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: width ?? double.infinity,
      child: OutlinedButton(
        onPressed: disabled ? null : onPressed,
        child: Text(label),
      ),
    );
  }
}

class TextButton_ extends ConsumerWidget {
  final String label;
  final VoidCallback onPressed;

  const TextButton_({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
