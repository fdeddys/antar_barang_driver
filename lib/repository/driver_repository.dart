import 'dart:convert';

import 'package:driverantar/dto/change_password_dto.dart';
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
            return LoginResultDto("",jsonObj['errCode'], jsonObj['errDesc']);
        }
        debugPrint("repository: login success");
        return LoginResultDto(jsonObj['token'], jsonObj['errCode'], jsonObj['errDesc']);
    }

    Future<Driver> getByCode(String driverCode, String _baseURL, String token) async {
        
        debugPrint("service getByCode $driverCode ");
        var _loginUrl = _baseURL + '/driver/code/$driverCode';

        // String token = Utilities.getToken();
        // var requestHeaders = Utilities.setSignature(token);
        
        debugPrint("Get driver by code $driverCode url " );
        var response =
            await client.get(Uri.parse(_loginUrl), 
                headers: {
                    'Authorization': 'Bearer $token',
                    'content-type': 'application/json',
                }
            );
        // var response =
        //     await client.get(Uri.parse(_loginUrl));

        String responseBody = utf8.decoder.convert(response.bodyBytes);
        debugPrint('service utf8 : ' + responseBody);
        final jsonObj = json.decode(responseBody) as Map<String, dynamic>;
        if (jsonObj['errCode'] != '00') {
            return Driver(0,'','','','','',0,'','');
        }
        Driver driver = Driver.fromJson(jsonObj['contents']);        
        return driver;
    }

    Future<ChangePassResultDto> changePassword(ChangePassDto changePassDto, String baseUrl, String token) async {

        var bodyJson = json.encode(changePassDto);
        var response = await client.post(
                Uri.parse(baseUrl+"/driver/change-password"), 
                body: bodyJson,
                headers: {
                    'Authorization': 'Bearer $token',
                    'content-type': 'application/json',
                }
            );

        String responseBody = utf8.decoder.convert(response.bodyBytes);
        debugPrint('service utf8 : ' + responseBody);

        final jsonObj = json.decode(responseBody) as Map<String, dynamic>;
        if (jsonObj['errCode'] != '00') {
            debugPrint("repository: login failed");
            return ChangePassResultDto("",jsonObj['errCode'], jsonObj['errDesc']);
        }
        debugPrint("repository: login success");
        return ChangePassResultDto(jsonObj['contents'], jsonObj['errCode'], jsonObj['errDesc']);
    }

}