import 'package:driverantar/page/account/change_password_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

    String id = "";
    String kode = "";
    String nama = "";
    String alamat = "";
    String hp = "";
    @override
    void initState() {
        super.initState();
        getData();
    }

    changePass() {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChangePasswordPage()),
        );
    }

    getData() async {
        
        final prefs = await SharedPreferences.getInstance();
 
        id =  prefs.getString('driver-id').toString();
        alamat = prefs.getString('driver-alamat').toString();
        hp = prefs.getString('driver-hp').toString();
        kode = prefs.getString('driver-kode').toString();
        nama =  prefs.getString('driver-nama').toString();
        setState(() => {
            
        });
    }

    @override
    Widget build(BuildContext context) {

        return  Scaffold(
            body: Container(
                    padding: const EdgeInsets.all(12),
                    child: Center(
                        child: Card(
                                elevation: 10,
                                color: Theme.of(context).colorScheme.surfaceVariant,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                        rowId(),
                                        rowKode(),
                                        rowNama(),
                                        rowAlamat(),
                                        btnChangePass()
                                    ],
                                ),
                        ),
                    ),
                ),
            );
    }

    Widget rowId(){
        return
            ListTile(
              leading: Icon(Icons.account_circle_outlined),
              title: const Text('ID'),
              subtitle: Text('$id'),
        );
    }

    Widget rowKode(){
        return
            ListTile(
              leading: Icon(Icons.lock_clock_outlined),
              title: const Text('Kode'),
              subtitle: Text('$kode'),
        );
    }

    Widget rowNama(){
        return
            ListTile(
              leading: Icon(Icons.verified_user),
              title: const Text('Nama'),
              subtitle: Text('$nama'),
        );
    }

    Widget rowAlamat(){
        return
            ListTile(
              leading: Icon(Icons.home),
              title: const Text('Alamat'),
              subtitle: Text('$alamat'),
        );
    }

    Widget btnChangePass(){
        return
            FloatingActionButton.extended(
                label: const Text('Change password'), 
                backgroundColor: Colors.blue,
                icon: const Icon( 
                    Icons.password_rounded,
                    size: 20.0,
                ),
                onPressed: () {
                    changePass();
                },
            );
    }
}