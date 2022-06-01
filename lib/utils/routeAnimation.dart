import 'package:flutter/material.dart';

class pageRoute extends PageRouteBuilder {
  final Widget child;
  pageRoute({required this.child})
      : super(
          fullscreenDialog: true,
          transitionDuration: const Duration(seconds: 2),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // TODO: implement buildTransitions
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
