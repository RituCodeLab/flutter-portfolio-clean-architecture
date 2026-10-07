import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:typed_data';
import 'dart:html' as html;
class CvDownloader {
  static Future<void> downloadCv() async {
    final ByteData data = await rootBundle.load(
      'assets/cv/Ritu_Nambath_Resume.pdf',
    );

    final Uint8List bytes = data.buffer.asUint8List();
    try {
      final blob = html.Blob(
        [bytes],
        'application/pdf',
      );

      final url = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(href: url)
        ..setAttribute(
          'download',
          'Ritu_Nambath_CV.pdf',
        )
        ..click();

      html.Url.revokeObjectUrl(url);
    } catch (e) {
      debugPrint('Error downloading CV: $e');
    }
  }
}
