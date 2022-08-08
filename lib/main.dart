import 'dart:ffi';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_complete_guide/widgets/AddTransactionModal.dart';
import 'package:flutter_complete_guide/widgets/chart.dart';
import 'package:flutter_complete_guide/widgets/expenceCard.dart';
import 'package:flutter_complete_guide/models/transaction.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePage();
  }
}

class MyHomePage extends State<App> {
  List<Transcation> transactions = [];

  onAdd(String title, double amount, DateTime date) {
    setState(() {
      transactions.add(Transcation(amount: amount, date: date, title: title));
    });
  }

  onDelete(id) {
    setState(() {
      transactions = transactions.where((expence) => expence.id != id).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
        ),
        body: Container(
          color: Color.fromARGB(255, 250, 250, 250),
          child: Column(
            children: [
              Chart(transactions),
              Text(
                "Transactions",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListView(
                scrollDirection: Axis.vertical,
                physics:
                    NeverScrollableScrollPhysics(), // <-- this will disable scroll
                shrinkWrap: true,
                children: [
                  ...(transactions
                      .map((e) => ExpenceCard(expence: e, onDelete: onDelete))
                      .toList())
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return AddTransactionModal(
                    onAdd,
                  );
                },
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Color.fromARGB(255, 238, 226, 117),
          ),
        ),
      ),
    );
  }
}
