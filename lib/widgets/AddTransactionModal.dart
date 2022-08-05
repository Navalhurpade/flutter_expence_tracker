import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransactionModal extends StatefulWidget {
  AddTransactionModal(this.onAdd);
  final Function onAdd;

  @override
  State<StatefulWidget> createState() {
    return _StateAddTransactionModal(onAdd);
  }
}

class _StateAddTransactionModal extends State<AddTransactionModal> {
  _StateAddTransactionModal(this.onAdd) : super();

  var selectedDate = DateTime.now();
  final Function onAdd;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: amountController,
            decoration: InputDecoration(labelText: 'Amount'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                DateFormat.yMMMd().format(selectedDate),
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              OutlinedButton(
                  child: Text('Select date'),
                  onPressed: () async {
                    selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                  }),
            ],
          ),
          FlatButton(
            textColor: Colors.purple,
            child: Text('Add transactions', style: TextStyle(fontSize: 16)),
            onPressed: () {
              print(
                  'IN ADD MODAL\n TITLE :: ${titleController.text}, AMOUNT :: ${amountController.text}');
              onAdd(titleController.text, double.parse(amountController.text),
                  selectedDate);
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
