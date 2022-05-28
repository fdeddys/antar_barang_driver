import 'dart:convert';

import 'package:driverantar/model/transaksi_model.dart';
import 'package:driverantar/util/util_signature.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransaksiRepository {

    final http.Client client;
    TransaksiRepository({required this.client});

    Future<int> setOnProccess(int transaksiId, int driverID, String _baseURL) async {

        var _transaksiUrl = _baseURL + '/transaksi/on-proccess';
        var requestHeaders = Utilities.setSignature();
        
        var transaksiRequest = {
            "id": transaksiId,
            "idDriver": driverID
        };
        var bodyJson = json.encode(transaksiRequest);
         
        var response =
            await client.post(Uri.parse(_transaksiUrl), body: bodyJson, headers: requestHeaders);

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

    Future<List<Transaksi>> getByDateByDriverPage(String sellerName, String driverId, String _baseURL, String tgl1, String tgl2, String status, int page, int count) async {
        
        var _transaksiUrl = _baseURL + '/transaksi/page/$page/count/$count';
        var requestHeaders = Utilities.setSignature();
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
            await client.post(Uri.parse(_transaksiUrl), body: bodyJson, headers: requestHeaders);

        // String responseBody = utf8.decoder.convert(response.bodyBytes);
        // debugPrint('service converted to utf ' );
        // final jsonObj = json.decode(responseBody) as Map<String, dynamic>;
        // if (jsonObj['count'] < 1 ) {
        //     print("data < 1 !!" );    
        //     return result;
        // }

        String responseBody = utf8.decoder.convert(response.bodyBytes);

        final jsonObj = json.decode(responseBody) as Map<String, dynamic>;
        print("SUDAH DECODE" );   
        print("Object "+ jsonObj.toString()); 
        if (jsonObj['count'].toString() == "0" ) {
            print("data < 1 !!" );    
            return result;
        }

        print("start convert !!" );
        if  (jsonObj['contents'] != []) {
            print("convert !!");
            result = (jsonObj['contents'] as List).map((i) => Transaksi.fromJson(i)).toList();
        }

        return result;
    }



}
