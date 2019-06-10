import 'package:string_unescape/string_unescape.dart';

main() {
  print(unescape(r"a\nb"));
  print(unescape(r"\x41"));
  print(unescapeChar(r"A"));
}
