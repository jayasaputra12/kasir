import 'package:flutter/material.dart';
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
}
