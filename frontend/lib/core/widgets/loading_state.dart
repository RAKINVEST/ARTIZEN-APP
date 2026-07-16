import 'package:flutter/material.dart';

/// The "chargement" state, used identically on every screen.
class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
