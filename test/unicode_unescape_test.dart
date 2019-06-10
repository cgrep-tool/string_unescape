import 'package:string_unescape/string_unescape.dart';
import 'package:test/test.dart';

void main() {
  group("unescape", () {
    test('string', () {
      expect(unescape(r"abcΩ\t123ΩΩΩ\n\"), "abcΩ\t123ΩΩΩ\n");
      expect(unescape(r"abcΩ\\abcΩ\\\\ΩΩ\\"), "abcΩ\\abcΩ\\\\ΩΩ\\");

      expect(unescape(r"a\zc"), "azc");

      expect(unescape(r"a\x0ab"), "a\nb");
      expect(unescape(r"a\u03a9b"), "aΩb");
      expect(unescape(r"a\u{1F000}b"), "a🀀b");
    });
    test('char', () {
      expect(unescapeChar(r"a"), 97);
      expect(() => unescapeChar(r"ab"), throwsA(isFormatException));
      expect(unescapeChar(r"Ω"), 937);
      expect(unescapeChar(r"🀀"), 0x1F000);
    });
  });
}
