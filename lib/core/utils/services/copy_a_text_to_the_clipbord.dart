import 'package:flutter/services.dart';
void copyToClipboard(String url) {
  Clipboard.setData(ClipboardData(text: url)).then((_) {
    print('URL copied to clipboard: $url');
  });
}
