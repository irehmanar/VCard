import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class VCardGenerator {
  static Future<String> generateVCard({
    required String name,
    required String? organization,
    required String workPhone,
    File? imageFile,
    String? email,
    String? address,
    String? website,
  }) async {
    StringBuffer vCardBuffer = StringBuffer();

    // Using \r\n as per the vCard specification
    vCardBuffer.writeln('BEGIN:VCARD\r\n');
    vCardBuffer.writeln('VERSION:3.0\r\n');
    vCardBuffer.writeln('FN:$name\r\n');
    vCardBuffer.writeln('ORG:$organization\r\n');
    vCardBuffer.writeln('TEL;TYPE=WORK:$workPhone\r\n');

    if (email != null && email.isNotEmpty) {
      vCardBuffer.writeln('EMAIL;TYPE=INTERNET:$email\r\n');
    }

    if (address != null && address.isNotEmpty) {
      vCardBuffer.writeln('ADR;TYPE=WORK:;;$address\r\n');
    }

    if (website != null && website.isNotEmpty) {
      vCardBuffer.writeln('URL:$website\r\n');
    }

    if (imageFile != null) {
      String base64Image = base64Encode(await imageFile.readAsBytes());
      String mimeType = _getMimeType(imageFile.path);
      vCardBuffer.writeln('PHOTO;ENCODING=b;TYPE=$mimeType:$base64Image\r\n');
    }

    vCardBuffer.writeln('END:VCARD\r\n');
    return vCardBuffer.toString();
  }

  static Future<void> shareVCard({
    required String vCardContent,
    required BuildContext context,
    required String name,
  }) async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/$name.vcf';
      File file = File(filePath);
      await file.writeAsString(vCardContent, flush: true);

      await Share.shareFiles(
        [file.path],
        text: 'Here is my vCard',
        mimeTypes: ['text/vcard'],  // Use the standard MIME type
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sharing vCard: $e'),
        ),
      );
    }
  }

  static String _getMimeType(String filePath) {
    final extension = filePath.split('.').last;
    switch (extension) {
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'gif':
        return 'image/gif';
      default:
        return 'application/octet-stream';
    }
  }
}
