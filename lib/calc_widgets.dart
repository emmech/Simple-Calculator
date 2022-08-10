import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calc_globals.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Calculator',
        style: TextStyle(
          color: Colors.blueGrey,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.black54,
    );
  }
}

class OpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: _buttonWidth,
        height: _buttonHeight,
        child: FittedBox(
            child: FloatingActionButton(
          elevation: 0.0,
          onPressed: () {
            _func(_value);
          },
          child: Text(
            _disp,
            style:
                TextStyle(fontSize: _fontSize, fontWeight: defaultFontWeight),
          ),
          backgroundColor: _myColor,
          foregroundColor: calcTheme.theme.appForeground,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
        )));
  }

  String _value = "";
  String _disp = "";
  double _fontSize = fontSize;
  double _buttonWidth = 10;
  double _buttonHeight = 10;
  Color _myColor = calcTheme.theme.appBackground;
  Function _func = () {};
  OpButton(val, buttonWidth, buttonHeight, Function func) {
    _value = val;
    _func = func;
    _disp = val;
    _buttonWidth = buttonWidth;
    _buttonHeight = buttonHeight;
    if (_value == '/')
      _disp = '\u00F7';
    else if (_value == '*')
      _disp = 'x';
    else if (_value == 'SQRT')
      _disp = '\u221A';
    else if (_value == 'PI')
      _disp = '\u03c0';
//    else if (_value == '^')
//      _disp = 'x\u02b8';
    else if (_value == 'SQ') {
      _disp = 'x\u00b2';
    } else if (_value == 'INC') {
      _disp = '\u2191';
      _fontSize = 30;
    } else if (_value == 'DISC') {
      _disp = '\u2193';
      _fontSize = 30;
    } else if (_value == 'SWAP') {
      _disp = '\u21c4';
      _fontSize = 30;
    } else if (_value == '+/-') _fontSize = 20;
  }
}

class NumberButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: _buttonWidth,
        height: _buttonHeight,
        child: FittedBox(
            child: FloatingActionButton(
          elevation: 0.0,
          onPressed: () {
            _func(_value);
          },
          child: Text(
            _value,
            style:
                TextStyle(fontSize: _fontSize, fontWeight: defaultFontWeight),
          ),
          backgroundColor: calcTheme.theme.appBackground,
          foregroundColor: calcTheme.theme.appForeground,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
        )));
  }

  String _value = "";
  double _fontSize = fontSize;
  double _buttonWidth = 20;
  double _buttonHeight = 20;
  Function _func = () {};
  NumberButton(val, buttonWidth, buttonHeight, Function func) {
    _value = val;
    _func = func;
    _buttonWidth = buttonWidth;
    _buttonHeight = buttonHeight;
  }
}

class MemButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: _buttonWidth,
        height: _buttonHeight,
        child: FittedBox(
            child: FloatingActionButton(
          elevation: 0.0,
          onPressed: () {
            _func(_value);
          },
          child: Text(
            _value,
            style:
                TextStyle(fontSize: _fontSize, fontWeight: defaultFontWeight),
          ),
          backgroundColor: _myColor,
          foregroundColor: calcTheme.theme.appForeground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
        )));
  }

  String _value = "";
  Color _myColor = calcTheme.theme.appBackground;
  double _buttonWidth = 20;
  double _buttonHeight = 20;
  double _fontSize = fontSize;
  Function _func = () {};
  MemButton(val, buttonWidth, buttonHeight, Function func) {
    _value = val;
    _func = func;
    _buttonWidth = buttonWidth;
    _buttonHeight = buttonHeight;
  }
}

class RndButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: _buttonWidth,
        height: _buttonHeight,
        child: FittedBox(
            child: FloatingActionButton(
          elevation: 0.0,
          onPressed: () {
            _func(_value);
          },
          child: Text(
            _value,
            style:
                TextStyle(fontSize: _fontSize, fontWeight: defaultFontWeight),
          ),
          backgroundColor: _myColor,
          foregroundColor: calcTheme.theme.appForeground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
        )));
  }

  String _value = "";
  Color _myColor = calcTheme.theme.appBackground;
  double _buttonWidth = 20;
  double _buttonHeight = 20;
  double _fontSize = 16;
  Function _func = () {};
  RndButton(val, buttonWidth, buttonHeight, Function func) {
    _value = val;
    _func = func;
    _buttonWidth = buttonWidth;
    _buttonHeight = buttonHeight;
    if (_value.length > 3) _fontSize = 16;
  }
}

class ClearButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: _buttonWidth,
        height: _buttonHeight,
        child: FittedBox(
            child: FloatingActionButton(
          elevation: 0.0,
          onPressed: () {
            _func(_value);
          },
          child: Text(
            _value,
            style:
                TextStyle(fontSize: _fontSize, fontWeight: defaultFontWeight),
          ),
          backgroundColor: calcTheme.theme.appBackground,
          foregroundColor: calcTheme.theme.appForeground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
        )));
  }

  String _value = "";
  Function _func = () {};
  double _buttonWidth = 20;
  double _buttonHeight = 20;
  double _fontSize = fontSize;
  ClearButton(val, buttonWidth, buttonHeight, Function func) {
    _value = val;
    _func = func;
    _buttonWidth = buttonWidth;
    _buttonHeight = buttonHeight;
  }
}

class ThemeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: _buttonWidth,
        height: _buttonHeight,
        margin: const EdgeInsets.all(0.0),
        child: FittedBox(
            child: FloatingActionButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          elevation: 0.0,
          onPressed: () {
            _func();
          },
          child: Icon(calcTheme.theme.themeIcon),
          backgroundColor: calcTheme.theme.appBackground,
          foregroundColor: calcTheme.theme.appForeground,
        )));
  }

  Function _func = () {};
  double _buttonWidth = 20;
  double _buttonHeight = 20;
  ThemeButton(buttonWidth, buttonHeight, Function func) {
    _func = func;
    _buttonWidth = buttonWidth;
    _buttonHeight = buttonHeight;
  }
}

class OpList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        reverse: true,
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(0.0),
            child: Text(
              _items[index],
              style: TextStyle(
                  fontWeight: defaultFontWeight,
                  color: calcTheme.theme.appForeground),
            ),
          );
        });
  }

  List<String> _items = <String>[];

  OpList(items) {
    _items = items;
  }
}
