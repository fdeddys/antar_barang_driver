

import 'package:driverantar/constanta/constanta.dart';
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
        if (result.isSuccess == true) {
            debugPrint("service: login success, save preference");
            await prefs.setString('driver-code', loginDto.kode);
        }
        return result;
    }

    getByCode() async {
        final prefs = await SharedPreferences.getInstance();
        final _baseURL = prefs.getString('serverIP').toString();
        
        final String? driverCode = prefs.getString('driver-code');
        debugPrint('Service : get driver by code');

        Driver driver = await repository.getByCode(driverCode.toString(), _baseURL);
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

}