import 'dart:html';

import 'package:driverantar/model/screen_argument.dart';
import 'package:driverantar/model/transaksi_model.dart';
import 'package:flutter/material.dart';

class DetailOrderPage extends StatefulWidget {
    DetailOrderPage({Key? key}) : super(key: key);
    static const routeName = '/detailOrder';

    @override
    State<DetailOrderPage> createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {


    @override
    Widget build(BuildContext context) {

        final screenArgument = ModalRoute.of(context)!.settings.arguments as ScreenArgument;

        return Scaffold(
            appBar: AppBar(
                title: const Text("Detail Page"),
            ),
            body: 
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        cardSeller(screenArgument.transaksi),
                        cardProduct(screenArgument.transaksi),
                        cardCustomer(screenArgument.transaksi),
                    ],
                ),
        );
    }

    Widget cardSeller(Transaksi transaksi) {
        return
            Center(
                child: Card(
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
                            child: 
                                Column(
                                    children: [
                                        Text('Seller : ${transaksi.sellerName}' ),
                                        Text('Address : ${transaksi.sellerAddress}' ),
                                        Text('Hp : ${transaksi.sellerHp}' ),
                                    ],
                                ),
                        ),
                    ),
                ),
            );
    }

    Widget cardProduct(Transaksi transaksi) {
        return
            Center(
                child: Card(
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
                            child: Text('Product : ${transaksi.namaProduct}' ),
                        ),
                    ),
                ),
            );
    }

    Widget cardCustomer(Transaksi transaksi) {
        return
            Center(
                child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
                        child: SizedBox(
                            width: MediaQuery. of(context). size. width * 0.9 ,
                            child: Column(
                                children: [
                                    Text('Customer : ${transaksi.customerName}' ),
                                    Text('Address : ${transaksi.customerAddress}' ),
                                    Text('Hp : ${transaksi.customerHp}' ),
                                ],
                            ),
                        ),
                    ),
                ),
            );
    }

}