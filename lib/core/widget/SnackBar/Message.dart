import 'package:flutter/material.dart';

class SnackBarMessage {
  void errorMessage({required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  void successMessage({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
