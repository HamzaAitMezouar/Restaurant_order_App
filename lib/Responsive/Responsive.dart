import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  Widget mobile;
  Widget tablet;
  Responsive({Key? key, required this.mobile, required this.tablet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      if (size.maxWidth < 600) {
        return mobile;
      } else {
        return tablet;
      }
    });
  }
}
