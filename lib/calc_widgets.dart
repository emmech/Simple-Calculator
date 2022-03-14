import 'package:flutter/material.dart';
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
            onPressed: () {_func(_value);},
            child:
              Text(_disp,
              style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.w300),),
            backgroundColor: _myColor,
            foregroundColor: calcTheme.theme.opButtonText,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))
            ),
        )
        ));
  }

  String _value = "";
  String _disp = "";
  bool _mini = false;
  double _fontSize = 20;
  double _buttonWidth = 10;
  double _buttonHeight = 10;
  Color _myColor = calcTheme.theme.opButton;

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
    else if (_value == '^')
      _disp = 'x\u02b8';
    else if (_value == 'SQ') {
      _disp = 'x\u00b2';
      _fontSize = 20;
    } else if (_value == 'DISC') {
      _disp = '\u2193';
      _fontSize = 30;
    } else if (_value == '+/-')
      _fontSize = 20;
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
              onPressed: () {_func(_value);},
              child:
              Text(_value,
                style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.w300),),
              backgroundColor: calcTheme.theme.numButton,
              foregroundColor: calcTheme.theme.numButtonText,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))
              ),

            )
        ));
  }

  String _value = "";
  bool _mini = false;
  double _fontSize = 20;
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
              onPressed: () {_func(_value);},
              child:
              Text(_value,
                style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.w300),),
              backgroundColor: _myColor,
              foregroundColor: calcTheme.theme.memButtonText,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
        )));
  }

  String _value = "";
  bool _mini = false;
  Color _myColor = calcTheme.theme.memButton;
  double _buttonWidth = 20;
  double _buttonHeight = 20;
  double _fontSize = 20;
  Function _func = () {};
  MemButton(val, buttonWidth, buttonHeight, Function func) {
    _value = val;
    _func = func;
    _buttonWidth = buttonWidth;
    _buttonHeight = buttonHeight;
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
              onPressed: () {_func(_value);},
              child:
              Text(_value,
                style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.w300),),
              backgroundColor: calcTheme.theme.clearButton,
              foregroundColor: calcTheme.theme.clearButtonText,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            )));
  }

  String _value = "";
  bool _mini = false;
  Function _func = () {};
  double _buttonWidth = 20;
  double _buttonHeight = 20;
  double _fontSize = 20;
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
        alignment: Alignment.topRight,
        margin: const EdgeInsets.all(0.0),
        child: FittedBox(
            child: FloatingActionButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              elevation: 0.0,
              onPressed: () {_func();},
              child: Icon(calcTheme.theme.themeIcon),
              backgroundColor: calcTheme.theme.clearButton,
              foregroundColor: calcTheme.theme.clearButtonText,
            )));
  }

  Function _func = () {};
  double _buttonWidth = 20;
  double _buttonHeight = 20;
  double _fontSize = 20;
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
            child: Text(_items[index],
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                  color: calcTheme.theme.opListText),
            ),);
        }
    );
  }

  List<String> _items = <String>[];

  OpList(items) {
    _items = items;
  }
}