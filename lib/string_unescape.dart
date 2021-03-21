library string_unescape;

String unescape(String input) {
  final sb = StringBuffer();

  while (input.isNotEmpty) {
    int index = input.indexOf("\\");
    // No escaped characters
    if (index == -1) {
      sb.write(input);
      break;
    }
    sb.write(input.substring(0, index));
    // Forward slash at the end of text. Ignore.
    if (index == input.length - 1) {
      break;
    }
    String select = String.fromCharCode(input.codeUnitAt(index + 1));
    input = input.substring(index + 2);
    switch (select) {
      case '\\':
        sb.write('\\');
        break;
      case 't':
        sb.write('\t');
        break;
      case 'r':
        sb.write('\r');
        break;
      case 'n':
        sb.write('\n');
        break;
      case 'f':
        sb.write('\f');
        break;
      case 'b':
        sb.write('\b');
        break;
      case 'v':
        sb.write('\v');
        break;
      case 'u':
        if (input.length < 4) {
          input = '';
          break;
        }
        if (input[0] != '{') {
          String digit = input.substring(0, 4);
          int? intDigit = int.tryParse(digit, radix: 16);
          if (intDigit == null || intDigit < 0) {
            break;
          }
          input = input.substring(4);
          sb.writeCharCode(intDigit);
        } else {
          final match = RegExp(r"{([a-zA-Z0-9]+)}").matchAsPrefix(input);
          if (match == null) {
            break;
          } else {
            input = input.substring(match.end);
            String digit = match[1]!;
            int? intDigit = int.tryParse(digit, radix: 16);
            if (intDigit == null || intDigit < 0) {
              break;
            }
            sb.writeCharCode(intDigit);
          }
        }
        break;
      case 'x':
        if (input.length < 2) {
          input = '';
          break;
        }
        String digit = input.substring(0, 2);
        input = input.substring(2);
        int? intDigit = int.tryParse(digit, radix: 16);
        if (intDigit == null || intDigit < 0) {
          break;
        }
        sb.writeCharCode(intDigit);
        break;
      default:
        sb.write(select);
        break;
    }
  }

  return sb.toString();
}

int? unescapeChar(String input) {
  String unescaped = unescape(input);
  if (unescaped.runes.length > 1) throw FormatException("Found mutliple characters ${unescaped.runes.length}!");
  if (unescaped.runes.isEmpty) return null;
  return unescaped.runes.elementAt(0);
}
