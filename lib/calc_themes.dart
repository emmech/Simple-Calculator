import 'package:flutter/material.dart';

import "calc_globals.dart";

class CalcTheme {
  var theme;

  CalcTheme(String themeType) {
    if (themeType == "dark") {
      theme = Dark();
      currentTheme = "dark";
    } else if (themeType == "bluish") {
      theme = Bluish();
      currentTheme = "bluish";
    } else if (themeType == "light") {
      theme = Light();
      currentTheme = "light";
    } else if (themeType == "greenish") {
      theme = Greenish();
      currentTheme = "greenish";
    }
  }
}

class Dark {
  Color appBackground = Colors.black26;
  Color appForeground = Colors.blueGrey;
  Color highlightText = Colors.white54;
  IconData themeIcon = Icons.wb_sunny;
}

class Greenish {
  Color appBackground = Colors.white70;
  Color appForeground = Colors.blueGrey;
  Color highlightText = Colors.black87;
  IconData themeIcon = Icons.wb_sunny_outlined;
}

class Bluish {
  Color appBackground = Colors.lightBlueAccent;
  Color appForeground = Colors.blueGrey;
  Color highlightText = Colors.white54;
  IconData themeIcon = Icons.wb_sunny;
}

class Light {
  Color appBackground = Colors.white;
  Color appForeground = Colors.blueGrey;
  Color highlightText = Colors.black87;
  IconData themeIcon = Icons.wb_sunny_outlined;
}
