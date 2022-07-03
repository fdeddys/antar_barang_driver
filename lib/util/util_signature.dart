import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:driverantar/constanta/constanta.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';


class Utilities {

    static bool isNumeric(String s) {
    if(s == null) {
        return false;
    }
       return double.tryParse(s) != null;
    }
    // static Future<String> getToken() async {
    //     debugPrint("set signature");
    //     final prefs = await SharedPreferences.getInstance();
    //     final String? token = await prefs.getString('token');
    //     // 'Authorization': 'Bearer $token'
    //     debugPrint("token get = " + token.toString());
    //     String tokenStr = token.toString();
    //     return tokenStr;
    // }

    static setSignature(String token ) async {
        
        debugPrint("set signature");
        // final prefs = await SharedPreferences.getInstance();
        // final token = prefs.getString('token').toString();
        // String token = await (Utilities.getToken()).toString();
        // String strToken = token.toString();
        // debugPrint("Token == > "+strToken);

        DateTime now = DateTime.now();
        DateFormat formatter = DateFormat('ddMMyyyy');
        String tanggal = formatter.format(now);

        String secretKey = SecretKey;
        var key = utf8.encode(secretKey);
        var bytes = utf8.encode("{}&$tanggal&$secretKey");

        var hmacSha512 = Hmac(sha512, key); // HMAC-SHA256
        var digest = hmacSha512.convert(bytes);

        Map<String, String> requestHeaders = {
            'content-type': 'application/json',
            'timestamp': '$tanggal',
            'signature': '$digest', 
            'Authorization': 'Bearer $token',
        };

        debugPrint("req header " + requestHeaders.toString());
        return requestHeaders;
    }

}
