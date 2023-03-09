import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SharedCode {
  final BuildContext context;

  SharedCode({required this.context});

  //Api constants

  static const String baseUrl = "https://project.banjarcode.com/api";

  //shared preferences constants
  static const String authJson = 'authJson';

  static Widget buildPopUp(
      {required Widget child, required BuildContext context}) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: child,
      ),
    );
  }

  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  //addImage function
  static Future<File?> addImage() async {
    final ImagePicker picker = ImagePicker();
    final File imagePicked = File(
        (await picker.pickImage(source: ImageSource.gallery, imageQuality: 50))!
            .path);
    CroppedFile? file = await ImageCropper().cropImage(
      sourcePath: imagePicked.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      uiSettings: [
        IOSUiSettings(title: 'Cropper'),
      ],
    );
    return File(file!.path);
  }

  //scan Barcode
  static Future<String?> scanBarcode() async {
    String? barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    return barcodeScanRes;
  }
}
