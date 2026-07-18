import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

import 'async_value_view.dart';

/// A screen that shows PDF bytes in an in-app preview, with the loading /
/// error / retry handling every screen in the app shares. Used for both a
/// real quote's PDF and the branding "aperçu du rendu" — same rendering, so
/// the two previews can never diverge.
class PdfPreviewScaffold extends StatelessWidget {
  const PdfPreviewScaffold({
    required this.title,
    required this.pdf,
    required this.onRetry,
    this.fileName = 'document.pdf',
    super.key,
  });

  final String title;
  final AsyncValue<Uint8List> pdf;
  final VoidCallback onRetry;
  final String fileName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: AsyncValueView(
        value: pdf,
        onRetry: onRetry,
        builder: (context, bytes) => PdfPreview(
          build: (_) => bytes,
          canChangePageFormat: false,
          canChangeOrientation: false,
          canDebug: false,
          pdfFileName: fileName,
        ),
      ),
    );
  }
}
