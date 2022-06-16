import 'package:driverantar/model/transaksi_model.dart';
import 'package:driverantar/repository/transaksi_repository.dart';
import 'package:driverantar/service/transaksi-service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
    HistoryPage({Key? key}) : super(key: key);

    @override
    State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

    final _formKeyHistory = GlobalKey<FormState>();
    int totalRecords = 0;
    int maxRecord =10;
    int page =1;
    List<Transaksi> transaksis = [];
    DateTime tglSearch = DateTime.now();

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
        var outputFormat = DateFormat('yyyy/MM/dd');
        var outputDate = outputFormat.format(tglSearch);


        transaksis =
            await transaksiService.getDoneTransaksiByDateByDriver(outputDate, page, maxRecord);
        setState(() => {
            debugPrint("Set state :" + transaksis.length.toString())
        });
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
                    key: _formKeyHistory,
                    child:
                        Padding(
                            padding: 
                                const EdgeInsets.all(8.0),
                                child: Column(
                                    children: [
                                        panelSearch(),
                                        // btnSearch(),
                                        panelList(),
                                    ],
                                ),
                        ),
                )
        );
    }

    Widget panelSearch(){
        return
            Card(
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        children: [
                            getDate(),
                            const SizedBox(
                                height:  10,
                            ),
                            btnSearch(),
                            const SizedBox(
                                height:  10,
                            ),
                        ],
                    ),
                ),
            );
    }

    Widget getDate(){
        return
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        RichText(
                            text: TextSpan(
                                    children: [
                                        const WidgetSpan(
                                            child: Icon(Icons.date_range, size: 24, color: Colors.blue,),
                                        ),
                                        TextSpan(
                                            text: 
                                                ' Tanggal Transaksi :  ',
                                                    style: TextStyle(
                                                        color: Colors.green.shade400,
                                                        fontSize: 16,
                                                    )
                                        ),
                                        TextSpan(
                                            text: ' ${DateFormat('dd-MMM-yyyy').format(tglSearch)} ',
                                                    style: const TextStyle(
                                                        color: Colors.redAccent,
                                                        fontSize: 16,
                                                    )
                                        )
                                    ]
                            ) 
                        ),
                        btnPilihTanggal(),
                    ],
                ),
            );
    }

    Widget btnPilihTanggal(){
        return
            FloatingActionButton.extended(
                label: const Text('Pilih Tanggal'), 
                backgroundColor: Colors.redAccent.shade100,
                icon: const Icon( 
                    Icons.date_range_rounded,
                    size: 14.0,
                ),
                onPressed: () async {
                    
                    DateTime? pickedDate = await showDatePicker(
                        context: context, 
                        initialDate: DateTime.now(), 
                        firstDate: DateTime.now(), 
                        lastDate: DateTime(2100),
                        helpText: 'Tanggal Transaksi',
                        initialEntryMode: DatePickerEntryMode.calendar,
                        errorFormatText: 'Enter valid date',
                        errorInvalidText: 'Enter date in valid range',
                    );
                    if (pickedDate != null && pickedDate != tglSearch){
                        setState(() {
                            tglSearch = pickedDate;
                        });
                    }
                    
                },
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

    Widget btnSearchX() {
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
                    if (_formKeyHistory.currentState!.validate()) {
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


    Widget btnSearch() {
        return
            SizedBox(
                width: MediaQuery.of(context).size.width * 2 / 3,
                child: FloatingActionButton.extended(
                    label: const Text('Search'), 
                    backgroundColor: Colors.blue.shade400,
                    icon: const Icon( 
                        Icons.search_rounded,
                        size: 20,
                    ),
                    foregroundColor: Colors.white,
                    onPressed: () async {               
                        if (_formKeyHistory.currentState!.validate()) {
                            searchPress();
                        }
                    },
                ),
            );
    }

}