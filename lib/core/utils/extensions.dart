import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';


extension DateTimeExt on DateTime {
  String toDateOnly() {
    initializeDateFormatting();
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd', 'en');
    return dateFormat.format(this);
  }

  String toDateOnlyWithTextMonth() {
    initializeDateFormatting();
    final DateFormat dateFormat = DateFormat('MMM d, y', 'en');
    return dateFormat.format(this);
  }

  String toDateAndTimeFormat() {
    initializeDateFormatting();
    final DateFormat dateFormat = DateFormat('h:mma, MMM d, y', 'en');
    return dateFormat.format(this);
  }
}
