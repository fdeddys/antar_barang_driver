
import 'package:driverantar/constanta/constanta.dart';
import 'package:driverantar/model/transaksi_model.dart';
import 'package:driverantar/repository/transaksi_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransaksiService {

    final TransaksiRepository repository;
    // final _baseURL = serverIP;

    TransaksiService({required this.repository});

    // getByTodayByDriverPage(String sellerName, int page, int total) async {
    //     final prefs = await SharedPreferences.getInstance();

    //     final _baseURL = prefs.getString('serverIP').toString();
    //     final token = prefs.getString('token').toString();
    //     final String? driverId = prefs.getString('driver-id');
    //     debugPrint('Service : get transaksi by date, driver code');

    //     var now =  DateTime.now();
    //     var formatter = DateFormat('yyyy-MM-dd');
    //     String tgl1 = formatter.format(now);
        
    //     // var tgl1 = '2022-01-01';
    //     // var tgl2 = '2022-12-01';
    //     var status = '1,2';
    //     List<Transaksi> transaksis = await repository.getByDateByDriverPage(sellerName, driverId.toString(), _baseURL, tgl1, tgl1, status, page, total, token);
    //     debugPrint("done transaksi-services get by today");
    //     return transaksis;
    // }

    getByTodayByDriverPage(String sellerName) async {
        final prefs = await SharedPreferences.getInstance();

        final _baseURL = prefs.getString('serverIP').toString();
        final token = prefs.getString('token').toString();
        final String? driverId = prefs.getString('driver-id');
        debugPrint('Service : get transaksi by date, driver code');

        var now =  DateTime.now();
        var formatter = DateFormat('yyyy-MM-dd');
        String tgl1 = formatter.format(now);
        
        var status = '1,2';
        List<Transaksi> transaksis = await repository.getByAntarDateByDriver(sellerName, driverId.toString(), _baseURL, tgl1, tgl1, status,  token);
        debugPrint("done transaksi-services get by req-antar date today");
        return transaksis;
    }


    getNewTransaksiByDate( int page, int total) async {
        
        final prefs = await SharedPreferences.getInstance();
        final _baseURL = prefs.getString('serverIP').toString();
        final token = prefs.getString('token').toString();
        debugPrint('Service : get NEW transaksi');

        var tgl1 = '2022-01-01';
        var tgl2 = '2022-12-01';
        var status = '0';
        var sellerName = '';
        var driverID = '';
        List<Transaksi> transaksis = await repository.getByDateByDriverPage(sellerName, driverID, _baseURL, tgl1, tgl2, status, page, total, token,"");
        debugPrint("Done NEW Trans");
        return transaksis;
    }

    setOnProccess(int transactionId) async {
        
        debugPrint('Service : SET ON PROCCESS transaksi');
        final prefs = await SharedPreferences.getInstance();
        final _baseURL = prefs.getString('serverIP').toString();
        final String? driverIdStr = prefs.getString('driver-id');
        final token = prefs.getString('token').toString();

        var driverId = int.parse(driverIdStr.toString());
        
        int totalRec  = await repository.setOnProccess(transactionId, driverId, _baseURL, token);
 
        return totalRec;
    }

    setOnTheWay(int transactionId, String photoUrl) async {
        
        debugPrint('Service : SET ON ThE WAy transaksi');
        final prefs = await SharedPreferences.getInstance();
        final _baseURL = prefs.getString('serverIP').toString();
         final token = prefs.getString('token').toString();
        int totalRec  = await repository.setOnTheWay(transactionId, photoUrl, _baseURL, token);
 
        return totalRec;
    }

    setDone(int transactionId, String photoUrl) async {
        
        debugPrint('Service : SET DONE transaksi');
        final prefs = await SharedPreferences.getInstance();
        final _baseURL = prefs.getString('serverIP').toString();
         final token = prefs.getString('token').toString();
        int totalRec  = await repository.setDone(transactionId, photoUrl, _baseURL, token);
 
        return totalRec;
    }

    getDoneTransaksiByDateByDriver(String tgl, int page, int total) async {
        
        final prefs = await SharedPreferences.getInstance();
        final _baseURL = prefs.getString('serverIP').toString();
        final token = prefs.getString('token').toString();
        debugPrint('Service : get NEW transaksi');

        // var tgl1 = '2000-01-01';
        // var tgl2 = '2099-12-01';
        var status = '3';
        var sellerName = '';
        var driverID = '';
        List<Transaksi> transaksis = await repository.getByDateByDriverPage(sellerName, driverID, _baseURL, tgl, tgl, status, page, total, token,"");
        debugPrint("Done NEW Trans");
        return transaksis;
    }

    getGrabTransaksiByRequestDate(String tgl, int page, int total) async {
        
        final prefs = await SharedPreferences.getInstance();
        final _baseURL = prefs.getString('serverIP').toString();
        final token = prefs.getString('token').toString();
        debugPrint('Service : get NEW transaksi');

        // var tgl1 = '2022-01-01';
        // var tgl2 = '2022-12-01';
        var status = '0';
        var sellerName = '';
        var driverID = '';
        List<Transaksi> transaksis = await repository.getByDateByDriverPage(sellerName, driverID, _baseURL, tgl, tgl, status, page, total, token, "/grab/by-tgl-antar");
        debugPrint("Done NEW Trans");
        return transaksis;
    }
}
