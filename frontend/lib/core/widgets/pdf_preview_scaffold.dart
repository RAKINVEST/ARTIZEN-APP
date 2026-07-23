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
        // A *copy* of the bytes on every build. On web the printing plugin
        // transfers the PDF's ArrayBuffer to a worker, which detaches it; a
        // rebuild (or leaving the screen) then re-posts the detached buffer and
        // throws "DataCloneError: An ArrayBuffer is detached". Handing out a
        // fresh copy each time keeps the source intact.
        builder: (context, bytes) => PdfPreview(
          build: (_) => Uint8List.fromList(bytes),
          canChangePageFormat: false,
          canChangeOrientation: false,
          canDebug: false,
          pdfFileName: fileName,
        ),
      ),
    );
  }
}
