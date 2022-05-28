import 'package:driverantar/config/app_config.dart';
import 'package:driverantar/dto/login_dto.dart';
import 'package:driverantar/page/mainmenu/main_menu_page.dart';
import 'package:driverantar/repository/driver_repository.dart';
import 'package:driverantar/service/driver-service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
    LoginPage({Key? key}) : super(key: key);

    @override
    State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

    final _formKey = GlobalKey<FormState>();
    // final _formKey = GlobalObjectKey<FormState>;


    TextEditingController textCodeController = TextEditingController();
    TextEditingController textPassController = TextEditingController();
    
    DriverService driverService = DriverService(repository: DriverRepository(client: http.Client()));

    loginPress() async {
        LoginDto loginDto =
            LoginDto(textCodeController.text, textPassController.text);

        debugPrint('Service : Login press');
        LoginResultDto resultLogin = await driverService.login(loginDto);
    
        if (resultLogin.isSuccess != true) {
            debugPrint("page: login failed");
            Fluttertoast.showToast(
                msg: "Login Failed !" + resultLogin.content,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red[300],
                textColor: Colors.white70,
                fontSize: 20.0);
            return;
        }
        await driverService.getByCode();
        debugPrint("page: login success");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainMenu()));
        return;
    }

    @override
    Widget build(BuildContext context) {
        

        return Scaffold(
            body: loginForm(),
        );
    }

    Widget loginForm() {
        return Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                    width: MediaQuery.of(context).size.width /3,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: 
                                            Image.asset("images/E1.png")
                                    ),
                                ),
                                ),
                        ],
                    ),
                    SingleChildScrollView(
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: inputPanel()
                        )
                    ),
                ],
            )
        );
    }

    Widget inputPanel(){
        var config = AppConfig.of(context);

        var urlApp = config!.apiBaseUrl.toString();
        return
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    inputCodeDriver(),
                    inputPassword(),
                    btnLogin(),
                    Text('${urlApp}')
                ],
            );
    }

    Widget inputCodeDriver(){
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
            controller: textCodeController,
            decoration: const InputDecoration(
                labelText: "Driver code",
                fillColor: Colors.black87,
                icon: Icon(Icons.account_circle)),
        );
    }

    Widget inputPassword() {
        return TextField(
        maxLines: 1,
        style: const TextStyle(
            color: Colors.black87,
        ),
        obscureText: true,
        maxLength: 50,
        controller: textPassController,
        decoration: const InputDecoration(
            labelText: "Password",
            fillColor: Colors.black87,
            icon: Icon(Icons.vpn_key_rounded)),
        );
    }

    Widget btnLogin() {
        return Padding(
            padding: const EdgeInsets.all(8),
            child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(22.0),
                color: Colors.blue.shade900,
                child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width - 40,
                padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () {
                    if (_formKey.currentState!.validate()) {
                    loginPress();
                    }
                },
                child: const Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                ),
            ),
        );
    }

}