import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calc_widgets.dart';
import 'calc_funcs.dart';
import 'calc_globals.dart';
import 'calc_themes.dart';

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
        theme: ThemeData(
          scaffoldBackgroundColor: calcTheme.theme.appBackground,
          fontFamily: GoogleFonts.rubik().fontFamily,
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    String op = "", disp = "", cs = "";
    op = func;
    if (func == '/')
      op = '\u00f7';
    else if (func == 'DISC')
      op = '\u2193';
    else if (func == 'INC')
      op = '\u2191';
    else if (func == 'SQRT' || func == 'SQ' || func == '=' || func == '!')
      op = '';
    cs = commaSeparated(op1);
    disp = cs;
    if (op != "") disp += op;

    if (op2 != "" && op != "") {
      cs = commaSeparated(op2);
      disp += cs;
    }
    String _memIcon = "";

    if (memDisp != "") {
      _memIcon = 'M';
    }

    MediaQueryData _mq = MediaQuery.of(context);

    double _hs = _mq.size.width;
    double _vs = _mq.size.height;
    double _ah = _mq.size.height - _mq.padding.top - _mq.padding.bottom - 25;
    double _buttonWidth = _hs / 5;
    double _buttonHeight = _hs / 6;
    _ah -= (_buttonHeight * 7);
    String rndDisp = "RND";
    if (rnd > 10) {
      rndDisp = "RND";
    } else if (rnd == 2) {
      rndDisp = "RND2";
    } else if (rnd == 4) {
      rndDisp = "RND4";
    }

    return Scaffold(
      backgroundColor: calcTheme.theme.appBackground,
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
                style: TextStyle(
                    color: calcTheme.theme.highlightText,
                    fontWeight: defaultFontWeight)),
          ),
          Expanded(
              child: Container(
            height: _ah * .1,
            width: _hs * .90,
            margin: const EdgeInsets.all(10.0),
            child: Text(
              '$memDisp',
              style: TextStyle(
                  color: calcTheme.theme.highlightText,
                  fontWeight: defaultFontWeight),
              textAlign: TextAlign.right,
            ),
          )),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Container(
              margin: const EdgeInsets.all(0.0),
              height: _ah * .40,
              width: _hs * .90,
              child: Center(
                child: OpList(hist),
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
                          color: calcTheme.theme.highlightText,
                          fontWeight: defaultFontWeight,
                        )),
                  )),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RndButton(rndDisp, _buttonWidth, _buttonHeight, rndFunc),
              OpButton("DISC", _buttonWidth, _buttonHeight, operFunc),
              OpButton("INC", _buttonWidth, _buttonHeight, operFunc),
              OpButton("SWAP", _buttonWidth, _buttonHeight, swapFunc),
              ThemeButton(_buttonWidth, _buttonHeight, themeFunc),
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
              OpButton("+/-", _buttonWidth, _buttonHeight, plusMinusFunc),
              OpButton('PI', _buttonWidth, _buttonHeight, piFunc),
              OpButton("!", _buttonWidth, _buttonHeight, operFunc),
              OpButton("%", _buttonWidth, _buttonHeight, operFunc),
              OpButton("^", _buttonWidth, _buttonHeight, operFunc),
            ]),
      ]),
    );
  }

  buttonFunc(String val, Function func) {
    setState(() {
      calcTheme = CalcTheme(currentTheme);
      HapticFeedback.heavyImpact();
      func(val);
    });
  }

  themeFunc() {
    setState(() {
      if (currentTheme == "dark") {
        calcTheme = CalcTheme("light");
      } else if (currentTheme == "light") {
        calcTheme = CalcTheme("dark");
      }
    });
  }

  memFunc(String val) {
    setState(() {
      calcTheme = CalcTheme(currentTheme);

      HapticFeedback.heavyImpact();
      MemFunc(val);
    });
  }

  clearFunc(String val) {
    setState(() {
      calcTheme = CalcTheme(currentTheme);
      HapticFeedback.heavyImpact();
      ClearFunc(val);
    });
  }

  digitFunc(String val) {
    setState(() {
      calcTheme = CalcTheme(currentTheme);
      HapticFeedback.heavyImpact();
      DigitFunc(val);
    });
  }

  piFunc(String val) {
    setState(() {
      calcTheme = CalcTheme(currentTheme);
      HapticFeedback.heavyImpact();
      PiFunc(val);
    });
  }

  plusMinusFunc(String val) {
    setState(() {
      calcTheme = CalcTheme(currentTheme);
      HapticFeedback.heavyImpact();
      PlusMinusFunc(val);
    });
  }

  operFunc(String thisOp) {
    setState(() {
      HapticFeedback.heavyImpact();
      OperFunc(thisOp);
    });
  }

  rndFunc(String thisOp) {
    setState(() {
      HapticFeedback.heavyImpact();
      RndFunc();
    });
  }

  swapFunc(String thisOp) {
    setState(() {
      HapticFeedback.heavyImpact();
      SwapFunc();
    });
  }
}
