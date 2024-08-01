import 'package:flutter/material.dart';

// Custom BorderRadius
abstract class CBorderRadius {
  static const BorderRadius all12 = BorderRadius.all(Radius.circular(12.0));
  static const BorderRadius all8 = BorderRadius.all(Radius.circular(8.0));
  static const BorderRadius all2 = BorderRadius.all(Radius.circular(2.0));
  static const BorderRadius all4 = BorderRadius.all(Radius.circular(4.0));

  static const BorderRadius top16 =
  BorderRadius.vertical(top: Radius.circular(16.0));
}
