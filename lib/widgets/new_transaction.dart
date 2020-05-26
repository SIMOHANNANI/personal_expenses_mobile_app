import 'package:flutter/material.dart';
//import './user_transaction.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              controller: titleController,
            ),
            Container(
              height: 10.0,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (value) => submitData,
            ),
            FlatButton(
              child: Text(
                'Save transaction',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black),
              ),
              color: Colors.lightBlueAccent,
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }

  void submitData() {
    final enteredTitle = titleController.text;
    double enteredAmount = double.parse(amountController.text);
    try {
      enteredAmount = double.parse(amountController.text);
    } finally {
      if (enteredTitle.isEmpty || enteredAmount <= 0) {
        // ignore: control_flow_in_finally
        return;
      }
    }
    widget.addTx(
      titleController.text,
      double.parse(
        amountController.text,
      ),
    );
    Navigator.of(context).pop();
  }
}
