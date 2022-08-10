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
//FontWeight defaultFontWeight = FontWeight.normal;
double fontSize = 22;

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
