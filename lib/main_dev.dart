
import 'package:driverantar/config/app_config.dart';
import 'package:driverantar/main.dart';
import 'package:flutter/widgets.dart';

void main() {
    var configureApp = AppConfig(
        appName: "Dev", 
        flavorName: "development", 
        apiBaseUrl: "http://localhost:8888/api", 
        child: MyApp()
    );

    runApp(configureApp);
}