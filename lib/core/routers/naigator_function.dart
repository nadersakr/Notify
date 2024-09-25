import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

navigateTo(BuildContext context, String path, {Map<String, dynamic>? extra}) {
  context.go(path, extra: extra);
}

navigatePushTo(BuildContext context, String path,
    {Map<String, dynamic>? extra}) {
  context.push(path, extra: extra);
}
navigatePushToScreen(BuildContext context, Widget screen,
    ) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
}
