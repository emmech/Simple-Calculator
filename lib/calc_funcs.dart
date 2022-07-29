import 'dart:math' as math;
import 'calc_globals.dart';

RndFunc() {
  if (rnd >= 10)
    rnd = 2;
  else if (rnd == 2)
    rnd = 4;
  else if (rnd == 4) rnd = 10;
}

SwapFunc() {
  if (op1 == "" || op2 == "" || func == "") return;
  String tempString = op1;
  num tempVal = op1Val;
  op1 = op2;
  op1Val = op2Val;
  op2 = tempString;
  op2Val = tempVal;
}

String toSuperscript(String val) {
  String superScript = "";

  for (int i = 0; i < val.length; i++) {
    switch (val[i]) {
      case '0':
        {
          superScript += '\u2070';
        }
        break;
      case '1':
        {
          superScript += '\u00B9';
        }
        break;
      case '2':
        {
          superScript += '\u00B2';
        }
        break;
      case '3':
        {
          superScript += '\u00B3';
        }
        break;
      case '4':
        {
          superScript += '\u2074';
        }
        break;
      case '5':
        {
          superScript += '\u2075';
        }
        break;
      case '6':
        {
          superScript += '\u2076';
        }
        break;
      case '7':
        {
          superScript += '\u2077';
        }
        break;
      case '8':
        {
          superScript += '\u2078';
        }
        break;
      case '9':
        {
          superScript += '\u2079';
        }
        break;
      case '.':
        {
          superScript += '\u02D9';
        }
        break;
      default:
        {
          superScript += val[i];
        }
    }
  }
  return superScript;
}

String commaSeparated(String line) {
  String cs = "";
  bool flag = false;
  int count = 0;

  if (line == "") return ("");

  if (line.contains(new RegExp('[a-z]'))) return line;

  if (line.contains('.')) {
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

String removeTrailingZeros(String line) {
  if (line == "" || line.contains(new RegExp('[a-z]')) || !line.contains('.'))
    return line;

  for (int i = line.length - 1; i >= 0; i--) {
    if (line[i] != '0') {
      if (line[i] == '.')
        return line.substring(0, i);
      else
        return line.substring(0, i + 1);
    }
  }
  return line;
}

MemFunc(String val) {
  if (val == "M+" || val == "M-") {
    if ((term1 && op1Val != 0 && op1Val.isFinite) ||
        (!term1 && op2Val == 0 && op1Val == math.pi)) {
      if (val == "M+")
        memVal += op1Val;
      else
        memVal -= op1Val;
    } else if (op2Val != 0 && op2Val.isFinite) {
      if (val == "M+")
        memVal += op2Val;
      else
        memVal -= op2Val;
    }
    if (memVal != 0) memDisp = commaSeparated(memVal.toString());
  } else if (val == "MR") {
    if (term1) {
      op1Val = memVal;
      op1 = op1Val.toString();
    } else {
      op2Val = memVal;
      op2 = op2Val.toString();
    }
  } else if (val == "MC") {
    memDisp = "";
    memVal = 0;
  } else if (val == "HC") {
    hist.clear();
  }
}

ClearFunc(String val) {
  termStart = true;
  if (val == "AC") {
    op1 = "";
    op2 = "";
    op1Val = 0;
    op2Val = 0;
    result = 0;
    term1 = true;
    func = "";
    result = 0;
  } else if (val == "C") {
    if (op2 == "") {
      op1 = "";
      op1Val = 0;
      func = "";
      term1 = true;
      result = 0;
    } else {
      op2 = "";
      op2Val = 0;
    }
  }
}

PlusMinusFunc(String val) {
  if (term1 || func == '=' || func == 'SQRT' || func == 'SQ' || func == '!') {
    op1Val *= -1;
    op1 = op1Val.toString();
    term1 = true;
  } else {
    if (op2 != "") {
      op2Val *= -1;
      op2 = op2Val.toString();
    }
  }
}

DigitFunc(String val) {
  if (term1) {
    if (termStart == true) {
      termStart = false;
      op1 = '';
      op1Val = 0;
    }
    if (val == '.' && op1.contains('.')) return;
    if (val == '.' && op1 == '')
      op1 = '0.';
    else
      op1 += val;
    op1Val = num.parse(op1);
  } else {
    if (termStart == true) {
      termStart = false;
      op2 = '';
      op2Val = 0;
      if (op1Val != math.pi) op1Val = num.parse(op1);
    }
    if (val == '.' && op2.contains('.')) return;
    if (val == '.' && op2 == '')
      op2 = '0.';
    else
      op2 += val;
    op2Val = num.parse(op2);
  }
}

PiFunc(String val) {
  String pi = '\u03c0';
  if (term1) {
    op1Val = math.pi;
    op1 = pi;
    term1 = false;
  } else if (func == '=' || func == "SQRT" || func == "SQ" || func == "!") {
    op1Val = math.pi;
    op1 = pi;
    term1 = true;
  } else {
    if (op1Val != math.pi) op1Val = num.parse(op1);
    op2Val = math.pi;
    op2 = pi;
  }
}

double factorial(num n) {
  double res = 1;

  for (num i = 1; i <= n; i++) {
    res *= i;
    if (res.isInfinite) return res;
  }

  return res;
}

BasicMath() {
  if (func == '/')
    result = op1Val / op2Val;
  else if (func == 'x')
    result = op1Val * op2Val.toDouble();
  else if (func == '+')
    result = op1Val + op2Val;
  else if (func == '-')
    result = op1Val - op2Val;
  else if (func == '^') {
    result = (math.pow(op1Val, op2Val.toDouble()));
  } else if (func == 'INC') {
    result = op1Val + (op1Val * op2Val) / 100;
  } else if (func == 'DISC') {
    result = op1Val - (op1Val * op2Val) / 100;
  } else if (func == '%')
    result = (op1Val / 100) * op2Val;
  else
    return;

  String dispRes = "";
  if (rnd > 4)
    dispRes = result.toString();
  else
    dispRes = result.toStringAsFixed(rnd);

  dispRes = removeTrailingZeros(dispRes);
  String _symbol = func;

  String cs1 = commaSeparated(op1);
  String cs2 = commaSeparated(op2);
  String cs3 = commaSeparated(dispRes);
  if (func == '/') _symbol = '\u00f7';

  if (func == '^' && cs2 != '\u03c0') {
    cs2 = toSuperscript(cs2);
    completeOp = '$cs1$cs2 = $cs3';
  } else if (func == 'INC') {
    completeOp = '$cs1 increased by $cs2% = $cs3';
  } else if (func == 'DISC') {
    completeOp = '$cs1 decreased by $cs2% = $cs3';
  } else {
    completeOp = '$cs1 $_symbol $cs2 = $cs3';
  }
  hist.insert(0, completeOp);
  op1Val = num.parse(dispRes);
  op1 = dispRes;
  op2 = "";
  op2Val = 0;
}

MoreMath() {
  String dispRes = "";
  if (func == 'SQRT') {
    result = math.sqrt(op1Val);
    if (rnd > 4)
      dispRes = result.toString();
    else
      dispRes = result.toStringAsFixed(rnd);
    dispRes = removeTrailingZeros(dispRes);
    String cs1 = commaSeparated(op1);
    String cs3 = commaSeparated(dispRes);
    completeOp = '\u221a$cs1 = $cs3';
  } else if (func == "SQ") {
    result = math.pow(op1Val, 2.0);
    if (rnd > 4)
      dispRes = result.toString();
    else
      dispRes = result.toStringAsFixed(rnd);
    dispRes = removeTrailingZeros(dispRes);
    String cs1 = commaSeparated(op1);
    String cs3 = commaSeparated(dispRes);
    completeOp = '$cs1\u00b2 = $cs3';
  } else if (func == '!') {
    result = factorial(op1Val);
    if (rnd > 4)
      dispRes = result.toString();
    else
      dispRes = result.toStringAsFixed(rnd);
    dispRes = removeTrailingZeros(dispRes);
    String cs1 = commaSeparated(op1);
    String cs3 = commaSeparated(dispRes);
    completeOp = '$cs1! = $cs3';
  } else {
    return;
  }
  op1Val = num.parse(dispRes);
  op1 = dispRes;
  op2 = "";
  op2Val = 0;
  hist.insert(0, completeOp);
}

OperFunc(String thisOp) {
  if (op1 == "" && op2 == "") {
    return;
  }

  if (term1) {
    term1 = false;
    termStart = true;
    if (op1[op1.length - 1] == '.') op1 += '0';
  }

  if (op1 != "" && op2 != "") {
    if (op2[op2.length - 1] == '.') op2 += '0';
    switch (func) {
      case "+":
      case '-':
      case 'x':
      case '/':
      case '^':
      case '%':
      case 'DISC':
      case 'INC':
        {
          BasicMath();
          if (thisOp == '=') {
            term1 = true;
            termStart = true;
          }
          func = thisOp;
        }
        break;
      default:
        {
          if (thisOp == '=') {
            term1 = true;
            termStart = true;
          }
          func = thisOp;
        }
        break;
    }
  } else if (op1 != "") {
    switch (thisOp) {
      case "SQRT":
      case "SQ":
      case "!":
        {
          func = thisOp;
          MoreMath();
          term1 = true;
          termStart = true;
        }
        break;
      default:
        {
          func = thisOp;
          if (func == '=') {
            term1 = true;
            termStart = true;
          }
        }
        break;
    }
  }
}
