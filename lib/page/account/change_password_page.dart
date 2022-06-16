import 'package:driverantar/dto/change_password_dto.dart';
import 'package:driverantar/repository/driver_repository.dart';
import 'package:driverantar/service/driver-service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ChangePasswordPage extends StatefulWidget {
    const ChangePasswordPage({ Key? key }) : super(key: key);

    @override
    State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

    final _formChangePassKey = GlobalKey<FormState>();

    TextEditingController textOldPasswordController = TextEditingController();
    TextEditingController textRePasswordController = TextEditingController();
    TextEditingController textNewPasswordController = TextEditingController();
    DriverService driverService = DriverService(repository: DriverRepository(client: http.Client()));


    ChangePress() async {
      
        debugPrint('Service : Change press');
        ChangePassResultDto resultChangePass = await driverService.changePass(textNewPasswordController.text, textOldPasswordController.text);
    
        if (resultChangePass.errCode != "00") {
            debugPrint("page: change failed");
            Fluttertoast.showToast(
                msg: "Login Failed !" + resultChangePass.errDesc + " - " + resultChangePass.contents,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red[300],
                textColor: Colors.white70,
                fontSize: 20.0);
            return;
        }
        
        Fluttertoast.showToast(
            msg: "Login Success !" ,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[300],
            textColor: Colors.white70,
            fontSize: 20.0
        );
        Navigator.pop(context);
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Change Password'),
            ),
            body: Form(
                key: _formChangePassKey,
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                fieldOldPass(),
                                fieldNewPass(),
                                fieldRePass(),
                                buttonChange()
                            ],
                        ),
                    ),
                )
            )
        ); 
    }

    Widget fieldOldPass(){
        return TextFormField(
            validator: (value) {
                if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                }
                return null;
            },
            maxLines: 1,
            style: const TextStyle(
                color: Colors.black87,
            ),
            autofocus: true,
            obscureText: true,
            maxLength: 50,
            controller: textOldPasswordController,
            decoration: const InputDecoration(
                labelText: "Old Password",
                fillColor: Colors.black87,
                icon: Icon(Icons.account_circle)),
        );
    }

    Widget fieldNewPass(){
        return TextFormField(
            validator: (value) {
                if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                }
                return null;
            },
            maxLines: 1,
            style: const TextStyle(
                color: Colors.black87,
            ),
            autofocus: true,
            maxLength: 50,
            obscureText: true,
            controller: textNewPasswordController,
            decoration: const InputDecoration(
                labelText: "New Password",
                fillColor: Colors.black87,
                icon: Icon(Icons.account_circle)),
        );
    }

    Widget fieldRePass(){
        return TextFormField(
            validator: (value) {
                if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                }
                return null;
            },
            maxLines: 1,
            style: const TextStyle(
                color: Colors.black87,
            ),
            autofocus: true,
            obscureText: true,
            maxLength: 50,
            controller: textRePasswordController,
            decoration: const InputDecoration(
                labelText: "Reinsert new Password",
                fillColor: Colors.black87,
                icon: Icon(Icons.account_circle)),
        );
    }

    Widget buttonChange(){
        return
            Center(
                child: FloatingActionButton.extended(
                    label: const Text('Change password'), 
                    backgroundColor: Colors.redAccent,
                    icon: const Icon( 
                        Icons.password_sharp,
                        size: 20.0,
                    ),
                    onPressed: () {
                        if ( _formChangePassKey.currentState!.validate() ) {
                            ChangePress();
                        }
                    },
                ),
            );
    }

}