

import 'package:driverantar/dto/change_password_dto.dart';
import 'package:driverantar/dto/login_dto.dart';
import 'package:driverantar/model/driver_model.dart';
import 'package:driverantar/repository/driver_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverService {
    final DriverRepository repository;
    // String _baseURL ;

    DriverService({required this.repository});

    Future<LoginResultDto> login(LoginDto loginDto) async {
        final prefs = await SharedPreferences.getInstance();
        final _baseURL = prefs.getString('serverIP').toString();

        debugPrint('Service : Driver login, base url ' + _baseURL);
        
        LoginResultDto result = await repository.login(loginDto, _baseURL);
        if (result.errCode == "00") {
            debugPrint("service: login success, save preference");
            await prefs.setString('driver-code', loginDto.kode);
            await prefs.setString('token', result.token.toString());
        }
        return result;
    }

    getByCode() async {
        final prefs = await SharedPreferences.getInstance();
        final _baseURL = prefs.getString('serverIP').toString();
        final token = prefs.getString('token').toString();
        final String? driverCode = prefs.getString('driver-code');
        debugPrint('Service : get driver by code');

        Driver driver = await repository.getByCode(driverCode.toString(), _baseURL, token);
        if (driver.id != 0) {
            await prefs.setString('driver-id', driver.id.toString());
            await prefs.setString('driver-alamat', driver.alamat);
            await prefs.setString('driver-hp', driver.hp);
            await prefs.setString('driver-kode', driver.kode);
            await prefs.setString('driver-nama', driver.nama);
            await prefs.setString('driver-photo', driver.photo);  
        }
        return true;
    }


    Future<ChangePassResultDto> changePass(String password, String oldPassword) async {
        final prefs = await SharedPreferences.getInstance();
        final _baseURL = prefs.getString('serverIP').toString();
        final driverId = prefs.getString('driver-id').toString();
        final token = prefs.getString('token').toString();
        var driverIdInt = int.parse(driverId);
        
        debugPrint('Service : Driver changePass, base url ' + _baseURL);
        ChangePassDto changePassDto =  ChangePassDto(driverIdInt, password, oldPassword);

        ChangePassResultDto result = await repository.changePassword(changePassDto, _baseURL, token);
        
        return result;
    }

    clearCache() async {
        final prefs = await SharedPreferences.getInstance();
        
        await prefs.remove('driver-id');
        await prefs.remove('driver-alamat');
        await prefs.remove('driver-hp');
        await prefs.remove('driver-kode');
        await prefs.remove('driver-nama');
        await prefs.remove('driver-photo');  
        await prefs.remove('driver-code');
        await prefs.remove('token');
        
    }

}