import 'package:craftyfashions_webapp/UI/Styling/Breakpoints.dart';
import 'package:flutter/cupertino.dart';

class ResponsiveLayout extends StatelessWidget {
  ResponsiveLayout({this.mobileBody, this.tabletBody, this.desktopBody});

  final Widget mobileBody;
  final Widget tabletBody;
  final Widget desktopBody;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, dimens) {
        if(dimens.maxWidth <kTabletBreakpoint){
          return mobileBody;
        }else if(dimens.maxWidth >= kTabletBreakpoint && dimens.maxWidth < kDesktopBreakpoint){
          return tabletBody ?? mobileBody;
        }else{
          return desktopBody;
        }
      },
    );
  }
}
