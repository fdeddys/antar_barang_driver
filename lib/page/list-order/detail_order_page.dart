
import 'package:driverantar/model/screen_argument.dart';
import 'package:driverantar/model/transaksi_model.dart';
import 'package:driverantar/repository/transaksi_repository.dart';
import 'package:driverantar/service/transaksi-service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class DetailOrderPage extends StatefulWidget {
    DetailOrderPage({Key? key}) : super(key: key);
    static const routeName = '/detailOrder';

    @override
    State<DetailOrderPage> createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {

     TransaksiService transaksiService = 
        TransaksiService(
            repository: 
                TransaksiRepository(
                    client: http.Client()
                )
            );
            
    pickupBarang(Transaksi transaksi) async {
        
        var totalData =
            await transaksiService.setOnTheWay(transaksi.id,"");

        if (totalData<1) {
            Fluttertoast.showToast(
                msg: "Picked status Failed !" ,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red[300],
                textColor: Colors.white70,
                fontSize: 20.0);
            
            return;
        }
        Fluttertoast.showToast(
            msg: "Pick status updated !" ,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[300],
            textColor: Colors.white70,
            fontSize: 20.0);
        setState(() {
            transaksi.status =2;
            transaksi.statusName = "ON_THE_WAY";
        });
        
    }

    doneOrder(Transaksi transaksi) async {
        
        var totalData =
            await transaksiService.setDone(transaksi.id,"");

        if (totalData<1) {
            Fluttertoast.showToast(
                msg: "DOne status Failed !" ,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red[300],
                textColor: Colors.white70,
                fontSize: 20.0);
               
            return;
        }
        Fluttertoast.showToast(
            msg: "Done status updated !" ,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[300],
            textColor: Colors.white70,
            fontSize: 20.0);
             setState(() {
                transaksi.status =3;
                transaksi.statusName = "DONE";
            });
    }

    @override
    Widget build(BuildContext context) {

        final screenArgument = ModalRoute.of(context)!.settings.arguments as ScreenArgument;

        return Scaffold(
            appBar: AppBar(
                title: const Text("Detail Page"),
            ),
            body: 
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            cardInfo(screenArgument.transaksi),
                            cardPickup(screenArgument.transaksi),
                            cardDone(screenArgument.transaksi),
                        ],
                    ),
                ),
        );
    }

    Widget cardInfo(Transaksi transaksi) {
        return
            Center(
                child: Card(
                    color: Colors.blue.shade100,
                    shadowColor: Colors.red.shade300,
                    borderOnForeground: true,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                            width: MediaQuery. of(context). size. width * 0.9 ,
                            child: 
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                    Text('ID : ${transaksi.id}'),
                                                    Text('[${transaksi.status}] ${transaksi.statusName}')
                                                ],
                                            ),
                                        ),
                                        // ignore: prefer_const_constructors
                                        Padding(
                                            padding : const EdgeInsets.all(5.0),
                                            child: const Text('Seller', 
                                                    style: TextStyle(
                                                        color: Colors.blue, fontSize: 16
                                                    ),
                                                ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(left: 20) ,  
                                            child: Text('${transaksi.sellerName} ',
                                                style: TextStyle(
                                                        color:  Colors.white, fontSize: 16
                                                    ),
                                            )
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: Text('${transaksi.sellerHp} ',
                                                style: TextStyle(
                                                        color:  Colors.white, fontSize: 16
                                                    ),
                                            ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: Text('${transaksi.sellerAddress}',
                                                style: TextStyle(
                                                        color:  Colors.white, fontSize: 16
                                                    ),
                                            ),
                                        ),
                                        const SizedBox(height: 10),

                                        // ignore: prefer_const_constructors
                                        Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: const Text('Product', style: TextStyle(color: Colors.blue, fontSize: 16),),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: Text('${transaksi.namaProduct} ' ),
                                        ),
                                        const SizedBox(height: 10),

                                        // ignore: prefer_const_constructors
                                        Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: const Text('Customer', style: TextStyle(color: Colors.blue, fontSize: 16),),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: Text('${transaksi.customerName} ' ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: Text('${transaksi.customerAddress} ' ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: Text('${transaksi.customerHp} ' ),
                                        ),   
                                        const SizedBox(height: 10),

                                        // ignore: prefer_const_constructors
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text('Info', style: TextStyle(color: Colors.blue, fontSize: 16),),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: Text('Antar : [ ${transaksi.tanggalRequestAntarStr} ] / [ ${transaksi.jamRequestAntar} ] ' ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: Text('${transaksi.keterangan} ' ),
                                        ), 
                                    ],
                                ),
                        ),
                    ),
                ),
            );
    }

    Widget cardPickup(Transaksi transaksi) {
        return
            Center(
                child: Card(
                    color: const Color.fromARGB(255, 185, 223, 186),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: SizedBox(
                            width: MediaQuery. of(context). size. width * 0.9 ,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    // ignore: prefer_const_constructors
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Text('Pickup', style: TextStyle(color: Colors.green, fontSize: 16),),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Text('Tanggal : ${transaksi.tanggalAmbilStr} ' ),
                                    ),
                                    Center(
                                        child:  
                                            MaterialButton(
                                                minWidth: MediaQuery. of(context). size. width * 0.4 ,
                                                child: transaksi.status ==1 ? const Text("Pickup Item proccess !") : const Text(" Already picked.. "),
                                                color: Colors.green.shade500,
                                                onPressed: (){
                                                    if (transaksi.status ==1) {
                                                        pickupBarang(transaksi);
                                                    } 
                                                }
                                            ),
                                    )
                                ],
                            ),
                        ),
                    ),
                ),
            );
    }

    Widget cardDone(Transaksi transaksi) {
        return
            Center(
                child: Card(
                    color: const Color.fromARGB(255, 241, 151, 151),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: SizedBox(
                            width: MediaQuery. of(context). size. width * 0.9 ,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    // ignore: prefer_const_constructors
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Text('Done', style: TextStyle(color: Colors.red, fontSize: 16),),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Text('Tanggal : ${transaksi.tanggalAmbilStr} ' ),
                                    ),
                                    Center(
                                        child: MaterialButton(
                                            minWidth: MediaQuery. of(context). size. width * 0.4 ,
                                            child: transaksi.status == 2 ? const Text("Done Proccess !") : const Text(" DISABLED.."),
                                            color: Colors.blue.shade500,
                                            onPressed: (){
                                                if (transaksi.status ==2) {
                                                        doneOrder(transaksi);
                                                    } 
                                            }),
                                    )
                                ],
                            ),
                        ),
                    ),
                ),
            );
    }

}