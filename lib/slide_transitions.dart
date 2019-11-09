import 'package:flutter/material.dart';
class SlideRoute extends PageRouteBuilder {
  final SlideRouteDirection direction;
  final Widget page;
  SlideRoute(this.page, {this.direction = SlideRouteDirection.right})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: getOffsetByDirection(direction),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeInOut)).animate(animation),
          child: child,
        ),
  );

}

Offset getOffsetByDirection(SlideRouteDirection direction){
  switch(direction){
    case SlideRouteDirection.top:
      return Offset(0, -1);
    case SlideRouteDirection.bottom:
      return Offset(0, 1);
    case SlideRouteDirection.left:
      return Offset(-1, 0);
    case SlideRouteDirection.right:
      return Offset(1, 0);
    default:
      return Offset(0, 0);
  }
}
enum SlideRouteDirection{
  top, bottom, left, right
}