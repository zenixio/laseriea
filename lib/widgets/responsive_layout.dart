import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:laseriea/utils/platform_utils.dart';
import 'package:laseriea/utils/ui_constants.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    required this.mobileApp,
    super.key,
    this.mobileWeb,
    this.tabletWeb,
    this.desktopWeb,
  });

  /// Constructs the mobile layout
  final Widget Function(BuildContext context) mobileApp;

  /// Constructs the mobile web layout
  final Widget Function(BuildContext context)? mobileWeb;

  /// Constructs the tablet layout layout
  final Widget Function(BuildContext context)? tabletWeb;

  /// Constructs the web layout layout
  final Widget Function(BuildContext context)? desktopWeb;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (!kIsWeb && (isAndroid() || isIOS())) {
      return mobileApp(context);
    }
    if (width < UIConstants.mobileWidthThreshold) {
      if (mobileWeb != null) {
        return mobileWeb!(context);
      }
    } else if (width < UIConstants.tabletWidthThreshold) {
      if (tabletWeb != null) {
        return tabletWeb!(context);
      }
    } else {
      if (desktopWeb != null) {
        return desktopWeb!(context);
      }
      if (tabletWeb != null) {
        return tabletWeb!(context);
      }
    }
    if (mobileWeb != null) {
      return mobileWeb!(context);
    }
    return mobileApp(context);
  }
}
