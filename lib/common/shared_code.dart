import 'package:flutter/material.dart';

class SharedCode {
  final BuildContext context;

  SharedCode({required this.context});

  //Api constants

  static const String baseUrl = "https://project.banjarcode.com";

  static Widget buildPopUp(
      {required Widget child, required BuildContext context}) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: child,
      ),
    );
  }
}
