import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:driverantar/constanta/constanta.dart';
import 'package:intl/intl.dart';


class Utilities {
  static setSignature() {
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
      'signature': '$digest'
    };
    return requestHeaders;
  }
}
