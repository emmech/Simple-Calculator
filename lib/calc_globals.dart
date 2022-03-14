import 'package:flutter/material.dart';

var calcTheme;
String currentTheme = "light";
final key1 = GlobalKey();
final key2 = GlobalKey();

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }
}

class CalcTheme {

  var theme;

  CalcTheme(String themeType) {
    if (themeType == "dark") {
      theme = Dark();
      currentTheme = "dark";
    }
    else {
      theme = Light();
      currentTheme = "light";
    }
  }
}

class Dark {
//  Color appForeground = Colors.black26;
  Color appForeground = Colors.black26;
  Color memIcon = Colors.blueGrey;
  Color memText = Colors.blueGrey;
  Color resultText = Colors.white54;
  Color opButton = Colors.black38;
  Color numButton = Colors.black38;
  Color memButton = Colors.black38;
  Color clearButton = Colors.black38;
  Color opButtonText = Colors.blueGrey;
  Color numButtonText = Colors.blueGrey;
  Color memButtonText = Colors.blueGrey;
  Color clearButtonText = Colors.blueGrey;
  Color opListText = Colors.blueGrey;
  IconData themeIcon = Icons.wb_sunny;
}

class Light {
  Color appForeground = Colors.white;
  Color memIcon = Colors.blueGrey;
  Color memText = Colors.blueGrey;
  Color resultText = Colors.black87;
  Color opButton = Colors.white;
  Color numButton = Colors.white;
  Color memButton = Colors.white10;
  Color clearButton = Colors.white10;
  Color opButtonText = Colors.blueGrey;
  Color numButtonText = Colors.blueGrey;
  Color memButtonText = Colors.blueGrey;
  Color clearButtonText = Colors.blueGrey;
  Color opListText = Colors.blueGrey;
  IconData themeIcon = Icons.wb_sunny_outlined;
}