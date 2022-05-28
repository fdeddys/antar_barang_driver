
import 'package:driverantar/constanta/constanta.dart';
import 'package:driverantar/model/transaksi_model.dart';
import 'package:driverantar/repository/transaksi_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransaksiService {

    final TransaksiRepository repository;
    // final _baseURL = serverIP;

    TransaksiService({required this.repository});

    getByTodayByDriverPage(String sellerName, int page, int total) async {
        final prefs = await SharedPreferences.getInstance();

        final _baseURL = prefs.getString('serverIP').toString();
        final String? driverId = prefs.getString('driver-id');
        debugPrint('Service : get transaksi by date, driver code');

        var tgl1 = '2022-01-01';
        var tgl2 = '2022-12-01';
        var status = '1,2';
        List<Transaksi> transaksis = await repository.getByDateByDriverPage(sellerName, driverId.toString(), _baseURL, tgl1, tgl2, status, page, total);
 
        return transaksis;
    }

    getNewTransaksiByDate( int page, int total) async {
        
        final prefs = await SharedPreferences.getInstance();
        final _baseURL = prefs.getString('serverIP').toString();

        debugPrint('Service : get NEW transaksi');

        var tgl1 = '2022-01-01';
        var tgl2 = '2022-12-01';
        var status = '0';
        var sellerName = '';
        var driverID = '';
        List<Transaksi> transaksis = await repository.getByDateByDriverPage(sellerName, driverID, _baseURL, tgl1, tgl2, status, page, total);
 
        return transaksis;
    }

    setOnProccess(int transactionId) async {
        
        debugPrint('Service : SET ON PROCCESS transaksi');
        final prefs = await SharedPreferences.getInstance();
        final _baseURL = prefs.getString('serverIP').toString();
        final String? driverIdStr = prefs.getString('driver-id');
        
        var driverId = int.parse(driverIdStr.toString());
        
        int totalRec  = await repository.setOnProccess(transactionId, driverId, _baseURL);
 
        return totalRec;
    }

}
