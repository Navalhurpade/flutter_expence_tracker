import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:intl/intl.dart';

class ExpenceCard extends StatelessWidget {
  const ExpenceCard({Key key, @required this.expence, @required this.onDelete})
      : super(key: key);

  final Transcation expence;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        // border: Border(
        //   bottom: BorderSide(width: 1, color: Color.fromARGB(255, 1, 42, 33)),
        // ),
      ),
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Row(
        children: [
          Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Color.fromARGB(255, 99, 217, 187),
            ),
            alignment: Alignment.center,
            child: Text(
              '₹${expence.amount}',
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.only(left: 15),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expence.title,
                  style: TextStyle(
                    color: Color(0xff0f4a3c),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat.yMMMd().format(expence.date),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Color.fromARGB(137, 25, 99, 97),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 140),
            child: GestureDetector(
              onTap: () {
                onDelete(expence.id);
              },
              child: Icon(
                Icons.delete,
                size: 30,
                color: Color.fromARGB(255, 2, 50, 46),
                semanticLabel: 'delete',
              ),
            ),
          )
        ],
      ),
    );
  }
}
