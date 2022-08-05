import 'package:flutter/cupertino.dart';

class Transcation {
  final id = UniqueKey().hashCode;
  final String title;
  final double amount;
  final DateTime date;

  Transcation(
      {@required this.amount, @required this.date, @required this.title});
}
