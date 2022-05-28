import 'package:driverantar/model/transaksi_model.dart';
import 'package:driverantar/repository/transaksi_repository.dart';
import 'package:driverantar/service/transaksi-service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


class PickOrderPage extends StatefulWidget {
    PickOrderPage({Key? key}) : super(key: key);

    @override
    State<PickOrderPage> createState() => _PickOrderPageState();
}

class _PickOrderPageState extends State<PickOrderPage> {
    
    final _formKeySearchPickOrder = GlobalKey<FormState>();

    TextEditingController textSearchController = TextEditingController();
    int totalRecords = 0;
    int maxRecord =10;
    int page =1;
    List<Transaksi> transaksis = [];

    TransaksiService transaksiService = 
        TransaksiService(
            repository: 
                TransaksiRepository(
                    client: http.Client()
                )
            );

    @override
    void initState() {
        super.initState();
        getData();
    }

    getData() async {
        // var sellerName = textSearchController.text;
        transaksis =
            await transaksiService.getNewTransaksiByDate( page, maxRecord);
        setState(() => {
            print("Set state :" + transaksis.length.toString())
        });
    }

    pickOrderAction(transactionId) async {
        
        var totalData =
            await transaksiService.setOnProccess(transactionId);

        if (totalData<1) {
            Fluttertoast.showToast(
                msg: "No Order Picked  !" ,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red[300],
                textColor: Colors.white70,
                fontSize: 20.0);
            
            return;
        }
        Fluttertoast.showToast(
            msg: "Order Picked !" ,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[300],
            textColor: Colors.white70,
            fontSize: 20.0);
        getData();
    }

    searchPress() async {

        debugPrint('Search : Search press');
        getData();
        Fluttertoast.showToast(
            msg: "Search  !" ,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[300],
            textColor: Colors.white70,
            fontSize: 20.0);
        return;
    
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body:  
                Form(
                    key: _formKeySearchPickOrder,
                    child:
                        Padding(
                            padding: 
                                const EdgeInsets.all(8.0),
                                child: Column(
                                    children: [
                                        // panelSearch(),
                                        btnSearch(),
                                        panelList(),
                                    ],
                                ),
                        ),
                )
        );
    }

    Widget panelSearch(){
        return TextFormField(
            maxLines: 1,
            style: const TextStyle(
                color: Colors.black87,
            ),
            autofocus: true,
            maxLength: 100,
            controller: textSearchController,
            decoration: const InputDecoration(
                labelText: "Seller name",
                fillColor: Colors.black87,
                icon: Icon(Icons.account_circle)),
        );
    }

    Widget panelList(){
        return
            Expanded(
                child: ListView.builder(
                    controller: ScrollController(),
                    itemCount: transaksis.length ,
                    itemBuilder: (context, position) {
                        final transaksi = transaksis[position];
                        return Card(
                            child: 
                                Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: itemPanel(transaksi),
                                ),
                        );
                    }
                ),
            );
    }

    Widget itemPanel(Transaksi transaksi){
        return ListTile(
            title: Padding(
              padding: const EdgeInsets.fromLTRB(0,8,0,8),
              child:
                titlePanel(transaksi.sellerName, transaksi.sellerHp, transaksi.sellerAddress) 
            ),
            subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    namaCustomer(transaksi.customerName),
                    namaProduct(transaksi.namaProduct),
                    jamAntar(transaksi.jamRequestAntar, transaksi.tanggalRequestAntarStr),
                    keterangan(transaksi.keterangan),
                    const SizedBox(height: 10),
                    btnPanel(transaksi.id)
                ],
            ),
        );
    }

    Widget titlePanel(String sellerName, String sellerHp, String sellerAddress){
        return
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    // const Text("Seller", style: const TextStyle(fontSize: 20, color: Colors.pinkAccent),),
                    namaSeller(sellerName, sellerHp )
                ],
            );
    }

    Widget btnPanel(int transaksiID){
        return
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    const Text(" "),
                    btnPickOrder(transaksiID)
                ],
            );
    }

    Widget btnPickOrder(int transaksiID){
        return
            FloatingActionButton.extended(
                label: const Text('Pick Order'), 
                backgroundColor: Colors.blueGrey,
                icon: const Icon( 
                    Icons.download,
                    size: 20.0,
                ),
                onPressed: () {
                    pickOrderAction(transaksiID);
                },
            );
    }

    Widget namaSeller(String sellerName, String sellerHp) {
        return
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment:CrossAxisAlignment.center,
                children: [ 
                    Text("$sellerName", style: const TextStyle(fontSize: 20, color: Colors.redAccent)),
                    Text("$sellerHp", style: const TextStyle(fontSize: 20, color: Colors.redAccent)),
                ],
            );
    }

    Widget namaCustomer(String customerName){
        return
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment:CrossAxisAlignment.center,
                children: [
                    const Text("Customer", style: const TextStyle(fontSize: 16, color: Colors.green)),
                    Text("${customerName}", style: const TextStyle(fontSize: 16, color: Colors.greenAccent))
                ],
            );
    }

    Widget namaProduct(String nama){
        return
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment:CrossAxisAlignment.center,
                children: [
                    const Text("Product"),
                    Text("${nama}")
                ],
            );
    }

    Widget jamAntar(String jam, String tanggal){
        return
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment:CrossAxisAlignment.center,
                children: [
                    const Text("Waktu antar "),
                    Text("${tanggal} / ${jam}")
                ],
            );
    }
    
    Widget keterangan(String keterangan){
        return
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment:CrossAxisAlignment.center,
                children: [
                    const Text("Keterangan"),
                    Text("${keterangan}")
                ],
            );
    }

    Widget btnSearch() {
        return Padding(
            padding: const EdgeInsets.all(8),
            child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(22.0),
                color: Colors.blue.shade400,
                child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width - 40,
                padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () {
                    if (_formKeySearchPickOrder.currentState!.validate()) {
                        searchPress();
                    }
                },
                child: const Text(
                    "Search",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                ),
            ),
        );
    }
}