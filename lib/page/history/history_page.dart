import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
    HistoryPage({Key? key}) : super(key: key);

    @override
    State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
    @override
    Widget build(BuildContext context) {
        return  Container(child:  Center(child: const Text("History")),);
    }
}