import 'package:driverantar/page/account/account_page.dart';
import 'package:driverantar/page/history/history_page.dart';
import 'package:driverantar/page/list-order/list_order_page.dart';
import 'package:driverantar/page/pick-order/pick_order_page.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
    MainMenu({Key? key}) : super(key: key);

    @override
    State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {

    int selectedIndex =0;

    final widgetOption = [
        ListOrderPage(),
        PickOrderPage(),
        HistoryPage(),
        UserPage(),
    ];

    void onItemTapped(int index){
        setState(() {
            selectedIndex=index;
        });
    }

    final widgetTitle = ['List Order Page','Pick Order Page', 'History Page', 'Account Page'];

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: 
                AppBar(
                    title: Text(widgetTitle.elementAt(selectedIndex))
                ),
            body: 
                Center(child: IndexedStack(
                        index: selectedIndex,
                        children: widgetOption
                    ),
                ),
                // Center(
                //     child: widgetOption.elementAt(selectedIndex)
                // ),
            bottomNavigationBar: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: const Icon(Icons.list_alt),
                        label: 'List Order',
                        tooltip: 'List order for today' 
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.handyman),
                        label: 'Pick Order' 
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.history),
                        label: 'History' 
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.supervised_user_circle),
                        label: 'Account' 
                    ),
                ],
                currentIndex: selectedIndex,
                // fixedColor: Colors.red,
                onTap: onItemTapped,
                selectedItemColor: Colors.red,
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: true,
            ),
        );
    }
}