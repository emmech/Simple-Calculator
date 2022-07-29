import 'package:flutter/material.dart';

var calcTheme;
String currentTheme = "dark";
final key1 = GlobalKey();
final key2 = GlobalKey();

String memDisp = "";
String op1 = "";
String op2 = "";
String func = "";
bool term1 = true;
bool termStart = true;
int rnd = 10;
num result = 0;
num memVal = 0;
num op1Val = 0;
num op2Val = 0;
List<String> hist = <String>[];
String completeOp = "";
RegExp regex = RegExp(r"([.]*0+)(?!.*\d)");
FontWeight defaultFontWeight = FontWeight.normal;

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
    } else {
      theme = Light();
      currentTheme = "light";
    }
  }
}

class Dark {
  Color appForeground = Colors.black26;
  Color memIcon = Colors.blueGrey;
  Color memText = Colors.blueGrey;
  Color resultText = Colors.white54;
  Color opButtonText = Colors.blueGrey;
  Color numButtonText = Colors.blueGrey;
  Color memButtonText = Colors.blueGrey;
  Color clearButtonText = Colors.blueGrey;
  Color opListText = Colors.blueGrey;
  Color opButton = Colors.black38;
  Color numButton = Colors.black38;
  Color memButton = Colors.black26;
  Color clearButton = Colors.black38;
  IconData themeIcon = Icons.wb_sunny;
}

class Light {
  Color appForeground = Colors.white;
  Color memIcon = Colors.blueGrey;
  Color memText = Colors.blueGrey;
  Color resultText = Colors.black87;
  Color opButtonText = Colors.blueGrey;
  Color numButtonText = Colors.blueGrey;
  Color memButtonText = Colors.blueGrey;
  Color clearButtonText = Colors.blueGrey;
  Color opListText = Colors.blueGrey;
  Color opButton = Colors.white;
  Color numButton = Colors.white;
  Color memButton = Colors.white;
  Color clearButton = Colors.white;
  IconData themeIcon = Icons.wb_sunny_outlined;
}
