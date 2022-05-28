
import 'package:driverantar/config/app_config.dart';
import 'package:driverantar/main.dart';
import 'package:flutter/widgets.dart';

void main() {
    var configureApp = AppConfig(
        appName: "Prod", 
        flavorName: "production", 
        apiBaseUrl: "http://156.67.214.228:8888/api", 
        child: MyApp()
    );

    runApp(configureApp);
}