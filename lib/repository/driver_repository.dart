import 'dart:convert';

import 'package:driverantar/dto/login_dto.dart';
import 'package:driverantar/model/driver_model.dart';
import 'package:driverantar/util/util_signature.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DriverRepository  {

    final http.Client client;
    DriverRepository({required this.client});

    Future<LoginResultDto> login(LoginDto loginDto, String baseUrl) async {

        var bodyJson = json.encode(loginDto);
        var response = await client.post(
                Uri.parse(baseUrl+"/driver/login"), 
                body: bodyJson
            );

        String responseBody = utf8.decoder.convert(response.bodyBytes);
        debugPrint('service utf8 : ' + responseBody);

        final jsonObj = json.decode(responseBody) as Map<String, dynamic>;
        if (jsonObj['errCode'] != '00') {
            debugPrint("repository: login failed");
            return LoginResultDto(false, jsonObj['contents']);
        }
        debugPrint("repository: login success");
        return LoginResultDto(true, jsonObj['contents']);
    }

    Future<Driver> getByCode(String driverCode, String _baseURL) async {
        
        var _loginUrl = _baseURL + '/driver/code/$driverCode';
        var requestHeaders = Utilities.setSignature();
        var response =
            await client.get(Uri.parse(_loginUrl), headers: requestHeaders);

        String responseBody = utf8.decoder.convert(response.bodyBytes);
        debugPrint('service utf8 : ' + responseBody);
        final jsonObj = json.decode(responseBody) as Map<String, dynamic>;
        if (jsonObj['errCode'] != '00') {
            return Driver(0,'','','','','',0,'','');
        }
        Driver driver = Driver.fromJson(jsonObj['contents']);        
        return driver;
    }

}