library canvas_core_module_text;

import 'package:flutter/material.dart';

enum fontOptions { Roboto, OpenSansCondensed }
enum colorOptions { Black, Red, Blue }

extension ColorEnumExtension on colorOptions {
  Color get getColor {
    switch (this) {
      case colorOptions.Black:
        return Colors.black;
      case colorOptions.Red:
        return Colors.red;
      case colorOptions.Blue:
        return Colors.blue;
      default:
        return Colors.black;
    }
  }
}

extension FontEnumExtension on fontOptions {
  String get getFont {
    switch (this) {
      case fontOptions.Roboto:
        return "Roboto";
      case fontOptions.OpenSansCondensed:
        return "OpenSansCondensed";
      default:
        return "Roboto";
    }
  }
}
