import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'calc_widgets.dart';
import 'dart:ui';
import 'calc_globals.dart';

void main() {
  calcTheme = CalcTheme("light");

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
            scaffoldBackgroundColor: calcTheme.theme.appForeground,
            fontFamily: 'OpenSans'),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String junk = "";
  String _mem = "";
  String _mainDisp = "";
  String _op1 = "";
  String _op2 = "";
  String _prevOp = "";
  bool _term1 = true;
  num _result = 0;
  num _inMem = 0;
  List<String> _listOfOps = <String>[];
  String _listItem = "";

  @override
  Widget build(BuildContext context) {
    String op = "", disp = "", cs = "";
    op = _prevOp;
    if (_prevOp == '!')
      op = '';
    else if (_prevOp == '/')
      op = '\u00f7';
    else if (_prevOp == 'DISC')
      op = '\u2193';
    else if (_prevOp == 'SQRT' || _prevOp == 'SQ' || _prevOp == '=') op = '';
    cs = commaSeparated(_op1);
    disp = cs;
    if (op != "") disp += op;
    if (_op2 != "") {
      cs = commaSeparated(_op2);
      disp += cs;
    }
    String _memIcon = "";
    String _memVal = "";

    if (_mem != "") {
      _memIcon = 'M';
      _memVal = _mem;
    }

    MediaQueryData _mq = MediaQuery.of(context);

    double _hs = _mq.size.width;
    double _vs = _mq.size.height;
    double _ah = _mq.size.height - _mq.padding.top - _mq.padding.bottom - 25;
    double _buttonWidth = _hs / 5;
    double _buttonHeight = _buttonWidth;
    _ah -= (_buttonHeight * 6);

    return Scaffold(
      backgroundColor: calcTheme.theme.appForeground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          title: Text("calc"),
        ),
      ),
      body: Column(key: key1, children: <Row>[
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            height: _ah * .1,
            margin: const EdgeInsets.all(10.0),
            width: _hs * .1,
            child: Text('$_memIcon',
                style: TextStyle(color: calcTheme.theme.memIcon)),
          ),
          Expanded(
              child: Container(
            height: _ah * .1,
            width: _hs * .90,
            margin: const EdgeInsets.all(10.0),
            child: Text(
              '$_memVal',
              style: TextStyle(color: calcTheme.theme.memText),
              textAlign: TextAlign.right,
            ),
          )),
          Container(
            height: _ah * .1,
            width: _hs * .1,
            margin: const EdgeInsets.all(0.0),
            child: ThemeButton(_hs * .3, _ah * .1, themeFunc),
          )
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Container(
              margin: const EdgeInsets.all(0.0),
              height: _ah * .40,
              width: _hs * .90,
              child: Center(
                child: OpList(_listOfOps),
              )),
        ]),
        Row(
            key: key2,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: _ah * .50,
                  width: _hs * .90,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomRight,
                    child: Text('$disp',
                        style: TextStyle(
                          color: calcTheme.theme.resultText,
                          fontWeight: FontWeight.w200,
                        )),
                  )),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MemButton("M+", _buttonWidth, _buttonHeight, memFunc),
              MemButton("M-", _buttonWidth, _buttonHeight, memFunc),
              MemButton("MR", _buttonWidth, _buttonHeight, memFunc),
              MemButton("MC", _buttonWidth, _buttonHeight, memFunc),
              MemButton("HC", _buttonWidth, _buttonHeight, memFunc),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumberButton("7", _buttonWidth, _buttonHeight, digitFunc),
              NumberButton("8", _buttonWidth, _buttonHeight, digitFunc),
              NumberButton("9", _buttonWidth, _buttonHeight, digitFunc),
              OpButton("/", _buttonWidth, _buttonHeight, operFunc),
              ClearButton("AC", _buttonWidth, _buttonHeight, clearFunc),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumberButton("4", _buttonWidth, _buttonHeight, digitFunc),
              NumberButton("5", _buttonWidth, _buttonHeight, digitFunc),
              NumberButton("6", _buttonWidth, _buttonHeight, digitFunc),
              OpButton("x", _buttonWidth, _buttonHeight, operFunc),
              ClearButton("C", _buttonWidth, _buttonHeight, clearFunc),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumberButton("1", _buttonWidth, _buttonHeight, digitFunc),
              NumberButton("2", _buttonWidth, _buttonHeight, digitFunc),
              NumberButton("3", _buttonWidth, _buttonHeight, digitFunc),
              OpButton("-", _buttonWidth, _buttonHeight, operFunc),
              OpButton("SQRT", _buttonWidth, _buttonHeight, operFunc),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumberButton("0", _buttonWidth, _buttonHeight, digitFunc),
              NumberButton(".", _buttonWidth, _buttonHeight, digitFunc),
              OpButton("=", _buttonWidth, _buttonHeight, operFunc),
              OpButton("+", _buttonWidth, _buttonHeight, operFunc),
              OpButton("SQ", _buttonWidth, _buttonHeight, operFunc),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              OpButton("+/-", _buttonWidth, _buttonHeight, digitFunc),
              OpButton('PI', _buttonWidth, _buttonHeight, digitFunc),
              OpButton("!", _buttonWidth, _buttonHeight, operFunc),
              OpButton("%", _buttonWidth, _buttonHeight, operFunc),
              OpButton("^", _buttonWidth, _buttonHeight, operFunc),
            ]),
      ]),
    );
  }

  String commaSeparated(String line) {
    String cs = "";
    bool flag = false;
    int count = 0;

    if (line == "") return ("");

    if (line.contains(new RegExp('[a-z]')))
      return line;
    else if (line.contains('.')) {
      for (int i = line.length - 1; i >= 0; i--) {
        cs += line[i];
        if (line[i] == '.')
          flag = true;
        else if (flag == true) {
          if (line[i] != '-') count++;
          if (count == 3 && i != 0 && line[i - 1] != '-') {
            cs += ',';
            count = 0;
          }
        }
      }
    } else {
      for (int i = line.length - 1; i >= 0; i--) {
        cs += line[i];
        if (line[i] != '-') count++;
        if (count == 3 && i != 0 && line[i - 1] != '-') {
          cs += ',';
          count = 0;
        }
      }
    }

    String ns = "";
    for (int i = cs.length - 1; i >= 0; i--) {
      ns += cs[i];
    }

    return ns;
  }

  memFunc(String val) {
    setState(() {
      calcTheme = CalcTheme(currentTheme);

      HapticFeedback.heavyImpact();

      RegExp regex = RegExp(r"([.]*0+)(?!.*\d)");

      if (val == "M+" && _mainDisp != "" && num.parse(_mainDisp).isFinite) {
        _inMem += num.parse(_mainDisp);
        _mem = commaSeparated(_inMem.toStringAsFixed(13).replaceAll(regex, ""));
      } else if (val == "M-" &&
          _mainDisp != "" &&
          num.parse(_mainDisp).isFinite) {
        _inMem -= num.parse(_mainDisp);
        _mem = commaSeparated(_inMem.toStringAsFixed(13).replaceAll(regex, ""));
      } else if (val == "MR") {
        _mainDisp = _inMem.toString();
        if (_term1) {
          _op1 = _inMem.toString();
        } else {
          _op2 = _inMem.toString();
        }
      } else if (val == "MC") {
        _mem = "";
        _inMem = 0;
      } else if (val == "HC") {
        _listOfOps.clear();
      }
    });
  }

  clearFunc(String val) {
    setState(() {
      calcTheme = CalcTheme(currentTheme);
      HapticFeedback.heavyImpact();
      if (val == "AC") {
        _op1 = "";
        _op2 = "";
        _mainDisp = "";
        _term1 = true;
        _prevOp = "";
      } else if (val == "C") {
        if (_op2 == "") {
          _op1 = "";
          _mainDisp = "";
          _prevOp = "";
          _term1 = true;
        } else {
          _op2 = "";
          _mainDisp = "";
        }
      }
    });
  }

  digitFunc(String val) {
    setState(() {
      calcTheme = CalcTheme(currentTheme);
      HapticFeedback.heavyImpact();
      if (val == 'PI') {
        if (_term1) {
          _op1 = math.pi.toString();
          _mainDisp = _op1;
        } else if (_prevOp == '=' ||
            _prevOp == "SQRT" ||
            _prevOp == "SQ" ||
            _prevOp == "!") {
          _op1 = math.pi.toString();
          _mainDisp = _op1;
          _term1 = true;
        } else {
          _op2 = math.pi.toString();
          _mainDisp = _op2;
        }
      } else if (val == '+/-') {
        if (_term1 ||
            _prevOp == '=' ||
            _prevOp == 'SQRT' ||
            _prevOp == 'SQ' ||
            _prevOp == '!') {
          _op1 = (num.parse(_op1) * -1).toString();
          _mainDisp = _op1;
          _term1 = true;
        } else {
          if (_op2 != "") {
            _op2 = (num.parse(_op2) * -1).toString();
            _mainDisp = _op2;
          }
        }
      } else if (_term1) {
        if (val == '.' && _op1.contains('.')) return;
        _op1 += val;
        _mainDisp = _op1;
      } else if (_prevOp == '=' ||
          _prevOp == "SQRT" ||
          _prevOp == 'SQ' ||
          _prevOp == '!') {
        if (val == '.' && _op1.contains('.')) return;
        _op1 = val;
        _mainDisp = _op1;
        _term1 = true;
      } else {
        if (val == '.' && _op2.contains('.')) return;
        _op2 += val;
        _mainDisp = _op2;
      }
    });
  }

  themeFunc() {
//    print("coordinates 1 ${key1.globalPaintBounds}");
    setState(() {
      if (currentTheme == "dark") {
        calcTheme = CalcTheme("light");
      } else {
        calcTheme = CalcTheme("dark");
      }
    });
  }

  double factorial(num n) {
    double result = 1;

    for (num i = 1; i <= n; i++) {
      result *= i;
      if (result.isInfinite) return result;
    }

    return result;
  }

  operFunc(String thisOp) {
    setState(() {
      HapticFeedback.heavyImpact();
      if (_op1 == "" && _op2 == "") {
        return;
      }

      if (_term1) {
        _term1 = false;
      }

      RegExp regex = RegExp(r"([.]*0+)(?!.*\d)");
      if (_op2 != "" && _op1 != "") {
        if (_prevOp == '/' && thisOp == '%')
          _result = ((double.parse(_op1) / double.parse(_op2)) * 100);
        else if (_prevOp == '/')
          _result = (double.parse(_op1) / double.parse(_op2));
        else if (_prevOp == 'x')
          _result = (double.parse(_op1) * double.parse(_op2));
        else if (_prevOp == '+')
          _result = (double.parse(_op1) + double.parse(_op2));
        else if (_prevOp == '-')
          _result = (double.parse(_op1) - double.parse(_op2));
        else if (_prevOp == '^')
          _result = (math.pow(double.parse(_op1), double.parse(_op2)));
        else if (_prevOp == 'DISC') {
          _result = double.parse(_op1) -
              ((double.parse(_op1) * double.parse(_op2)) / 100);
        } else if (_prevOp == '%')
          _result = (double.parse(_op1) / 100) * double.parse(_op2);
        else
          return;

        _mainDisp = _result.toStringAsFixed(13).replaceAll(regex, "");
        String _symbol = _prevOp;
        if (_prevOp == '/') _symbol = '\u00f7';

        String cs1 = commaSeparated(_op1);
        String cs2 = commaSeparated(_op2);
        String cs3 = commaSeparated(_mainDisp);

        if (_prevOp == '/' && thisOp == '%') {
          _listItem = '$cs1 $_symbol $cs2 = $cs3%';
          _listOfOps.insert(0, _listItem);
          _op1 = _mainDisp;
          _op2 = "";
          _prevOp = '=';
        } else if (_prevOp == 'DISC') {
          _listItem = '$cs1 discounted by $cs2% = $cs3';
          _listOfOps.insert(0, _listItem);
          _op1 = _mainDisp;
          _op2 = "";
          _prevOp = thisOp;
        } else {
          _listItem = '$cs1 $_symbol $cs2 = $cs3';
          _listOfOps.insert(0, _listItem);
          _op1 = _mainDisp;
          _op2 = "";
          _prevOp = thisOp;
        }
      } else if (thisOp == "SQRT" && _op1 != "") {
        _result = math.sqrt(double.parse(_op1));
        _mainDisp = _result.toStringAsFixed(13).replaceAll(regex, "");
        String cs1 = commaSeparated(_op1);
        String cs3 = commaSeparated(_mainDisp);
        _listItem = '\u221a$cs1 = $cs3';
        _op1 = _mainDisp;
        _op2 = "";
        _listOfOps.insert(0, _listItem);
        _prevOp = thisOp;
      } else if (thisOp == "SQ" && _op1 != "") {
        _result = math.pow(double.parse(_op1), 2);
        _mainDisp = _result.toStringAsFixed(13).replaceAll(regex, "");
        String cs1 = commaSeparated(_op1);
        String cs3 = commaSeparated(_mainDisp);
        _listItem = '$cs1\u00b2 = $cs3';
        _op1 = _mainDisp;
        _op2 = "";
        _listOfOps.insert(0, _listItem);
        _prevOp = thisOp;
      } else if (thisOp == '!' && _op1 != "") {
        _result = factorial(num.parse(_op1));
        _mainDisp = _result.toStringAsFixed(13).replaceAll(regex, "");
        String cs1 = commaSeparated(_op1);
        String cs3 = commaSeparated(_mainDisp);
        _listItem = '$cs1! = $cs3';
        _op1 = _mainDisp;
        _op2 = "";
        _listOfOps.insert(0, _listItem);
        _prevOp = thisOp;
      } else {
        _prevOp = thisOp;
      }
    });
  }
}
