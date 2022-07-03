import 'package:url_launcher/url_launcher.dart';

class MapUtils {

    MapUtils._();

    static Future<void> openMap(double latitude, double longitude) async {
        
        final Uri googleUrlApp = Uri.parse(
            'comgooglemaps://?center=$latitude,$longitude');
        
        final Uri googleUrl = Uri.parse(
            'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

        // var googleUrl = Uri.parse("google.navigation:q=$latitude,$longitude&mode=d");

        if (await canLaunchUrl(Uri.parse("comgooglemaps://"))) {
            print("URL App : "+ googleUrlApp.toString());
            await launchUrl(googleUrlApp, mode: LaunchMode.inAppWebView);
        } else if (await canLaunchUrl(googleUrl)){
            print("URL Broeser : "+ googleUrl.toString());
            await launchUrl(googleUrl, mode: LaunchMode.externalApplication);
        } else {
            throw 'Could not open the map.';
        }
    }
}