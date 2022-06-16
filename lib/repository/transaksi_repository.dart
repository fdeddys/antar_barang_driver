import 'dart:convert';

import 'package:driverantar/model/transaksi_model.dart';
import 'package:driverantar/util/util_signature.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class TransaksiRepository {

    final http.Client client;
    TransaksiRepository({required this.client});

    Future<int> setOnProccess(int transaksiId, int driverID, String _baseURL, String token) async {

        var _transaksiUrl = _baseURL + '/transaksi/on-proccess';
        var requestHeaders = Utilities.setSignature(token);
        
        var transaksiRequest = {
            "id": transaksiId,
            "idDriver": driverID
        };
        var bodyJson = json.encode(transaksiRequest);
         
        var response =
            await client.post(Uri.parse(_transaksiUrl), body: bodyJson, headers: {
                'Authorization': 'Bearer $token',
                'content-type': 'application/json',
            });

        String responseBody = utf8.decoder.convert(response.bodyBytes);
        debugPrint('service utf8 : ' + responseBody);

        final jsonObj = json.decode(responseBody) as Map<String, dynamic>;
        if (jsonObj['errCode'] != '00') {
            debugPrint("repository: login failed");
            return  0;
        }
        debugPrint("repository: login success");
        var totalRec = jsonObj['contents'];
        return totalRec;
    }

    Future<List<Transaksi>> getByDateByDriverPage(String sellerName, String driverId, String _baseURL, String tgl1, String tgl2, String status, int page, int count, String token, String grabUrl) async {
        
        var _transaksiUrl = _baseURL + '/transaksi$grabUrl/page/$page/count/$count';
        // var requestHeaders = Utilities.setSignature(token);
        List<Transaksi> result=[];

        var transaksiRequest = {
            "tgl1": tgl1,
            "tgl2": tgl2,
            "driverId": driverId,
            "status": status,
            "sellerName": sellerName
        };
        var bodyJson = json.encode(transaksiRequest);
         
        var response =
            await client.post(Uri.parse(_transaksiUrl), body: bodyJson, headers: {
                'Authorization': 'Bearer $token',
                'content-type': 'application/json',
            });

        // String responseBody = utf8.decoder.convert(response.bodyBytes);
        // debugPrint('service converted to utf ' );
        // final jsonObj = json.decode(responseBody) as Map<String, dynamic>;
        // if (jsonObj['count'] < 1 ) {
        //     print("data < 1 !!" );    
        //     return result;
        // }

        String responseBody = utf8.decoder.convert(response.bodyBytes);

        final jsonObj = json.decode(responseBody) as Map<String, dynamic>;
        // debugPrint("Mulsi" );   
        // debugPrint("Object "+ jsonObj.toString()); 
        if (jsonObj['totalRow'].toString() == "0" ) {
            debugPrint("data < 1 !!" );    
            return result;
        }

        debugPrint("data lebih dari 0");

        // if (jsonObj['errCode'].toString() != "00" ) {
        //     debugPrint("ERR CODE"+ jsonObj['errCode']);
        //     Fluttertoast.showToast(
        //         msg: jsonObj['errDesc'].toString() ,
        //         toastLength: Toast.LENGTH_SHORT,
        //         gravity: ToastGravity.CENTER,
        //         timeInSecForIosWeb: 1,
        //         backgroundColor: Colors.red[300],
        //         textColor: Colors.white70,
        //         fontSize: 20.0);    
        //     return result;
        // }

        debugPrint("start convert !! ");

        // if  (jsonObj['contents'] == "NULL") {
        //     print("null !!");
        //     // result = [];
        //     return [];
        // }


        // if  (jsonObj['contents'] == 'Null' ) {
        //     print("null !");
        //     result = [];
        // }

        if  (jsonObj['contents'] != []) {
            debugPrint("convert !!");
            result = (jsonObj['contents'] as List).map((i) => Transaksi.fromJson(i)).toList();
        }
        debugPrint("done...!");

        return result;
    }

    Future<int> setOnTheWay(int transaksiId, String photoUrl, String _baseURL, String token) async {

        var _transaksiUrl = _baseURL + '/transaksi/on-the-way';
        // var requestHeaders = Utilities.setSignature(token);
        
        var transaksiRequest = {
            "id": transaksiId,
            "photoAmbil": photoUrl
        };
        var bodyJson = json.encode(transaksiRequest);
         
        var response =
            await client.post(Uri.parse(_transaksiUrl), body: bodyJson, headers: {
                'Authorization': 'Bearer $token',
                'content-type': 'application/json',
            });

        String responseBody = utf8.decoder.convert(response.bodyBytes);
        debugPrint('service utf8 : ' + responseBody);

        final jsonObj = json.decode(responseBody) as Map<String, dynamic>;
        if (jsonObj['errCode'] != '00') {
            debugPrint("repository: failed");
            return  0;
        }
        debugPrint("repository: set onthe way success");
        // var totalRec = jsonObj['contents'];
        return 1;
    }

    Future<int> setDone(int transaksiId, String photoUrl, String _baseURL, String token) async {

        var _transaksiUrl = _baseURL + '/transaksi/done';
        // var requestHeaders = Utilities.setSignature(token);
        
        var transaksiRequest = {
            "id": transaksiId,
            "photoSampai": photoUrl
        };
        var bodyJson = json.encode(transaksiRequest);
         
        var response =
            await client.post(Uri.parse(_transaksiUrl), body: bodyJson, headers: {
                'Authorization': 'Bearer $token',
                'content-type': 'application/json',
            });

        String responseBody = utf8.decoder.convert(response.bodyBytes);
        debugPrint('service utf8 : ' + responseBody);

        final jsonObj = json.decode(responseBody) as Map<String, dynamic>;
        if (jsonObj['errCode'] != '00') {
            debugPrint("repository: failed");
            return  0;
        }
        debugPrint("repository: set onthe way success");
        // var totalRec = jsonObj['contents'];
        return 1;
    }

    Future<List<Transaksi>> getByAntarDateByDriver(String sellerName, String driverId, String _baseURL, String tgl1, String tgl2, String status, String token) async {
        
        var _transaksiUrl = _baseURL + '/transaksi/antar';
        // var requestHeaders = Utilities.setSignature(token);
        List<Transaksi> result=[];

        var transaksiRequest = {
            "tgl1": tgl1,
            "tgl2": tgl2,
            "driverId": driverId,
            "status": status,
            "sellerName": sellerName
        };
        var bodyJson = json.encode(transaksiRequest);
         
        var response =
            await client.post(Uri.parse(_transaksiUrl), body: bodyJson, headers: {
                'Authorization': 'Bearer $token',
                'content-type': 'application/json',
            });

        String responseBody = utf8.decoder.convert(response.bodyBytes);

        final jsonObj = json.decode(responseBody) as Map<String, dynamic>;
        if (jsonObj['totalRow'].toString() == "0" ) {
            debugPrint("data < 1 !!" );    
            return result;
        }

        debugPrint("data lebih dari 0");

        if  (jsonObj['contents'] != []) {
            debugPrint("convert !!");
            result = (jsonObj['contents'] as List).map((i) => Transaksi.fromJson(i)).toList();
        }
        debugPrint("done...!");

        return result;
    }
}
