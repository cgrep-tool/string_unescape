# String unescape

Handy utility to unescape string representation (unicode, newline, tab, etc).

# Example

## Unescape string

```dart
expect(unescape(r"a\nb"), "a\nb");
expect(unescape(r"a\x0ab"), "a\nb");
```

## Unescape character

```dart
expect(unescapeChar(r"a"), 97);
expect(unescapeChar(r"🀀"), 0x1F000);
```
