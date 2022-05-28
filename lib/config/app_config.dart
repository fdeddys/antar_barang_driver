

import 'package:flutter/widgets.dart';

// https://iiro.dev/separating-build-environments/
class AppConfig extends InheritedWidget {

    AppConfig({
        required this.appName,
        required this.flavorName,
        required this.apiBaseUrl,
        required Widget child,
    }) :super(child: child) ;

    final String? appName;
    final String flavorName;
    final String apiBaseUrl;

    static AppConfig? of(BuildContext buildContext) {
        return buildContext.dependOnInheritedWidgetOfExactType<AppConfig>();
    }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

}