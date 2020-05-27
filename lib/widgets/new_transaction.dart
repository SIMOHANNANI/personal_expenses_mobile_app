import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  DateTime _pickedDate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: LayoutBuilder(builder: (ctx, constraints) {
        return Container(
          color: Theme.of(context).primaryColorLight,
          child: Card(
            color: Colors.transparent,
            elevation: 0.0,
            child: Container(
              padding: EdgeInsets.only(
                top: 100.0,
                bottom: MediaQuery.of(context).viewInsets.bottom + 70,
                left: constraints.maxWidth * 0.1,
                right: constraints.maxWidth * 0.1,
              ),
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
                    onSubmitted: (value) => _submitData,
                  ),
                  Container(
                    height: 70.0,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            _pickedDate == null
                                ? 'No Date chosen!'
                                : "You just picked : ${DateFormat.yMd().format(_pickedDate)}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17.0),
                          ),
                        ),
                        FlatButton(
                          child: Text(
                            'choose a date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: _presentDatePicker,
                          textColor: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'Save transaction',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: _submitData,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void _submitData() {
    final _enteredTitle = titleController.text;
    double enteredAmount = double.parse(amountController.text);
    try {
      enteredAmount = double.parse(amountController.text);
    } finally {
      if (_enteredTitle.isEmpty || enteredAmount <= 0 || _pickedDate == null) {
        // ignore: control_flow_in_finally
        return;
      }
    }
    widget.addTx(
        titleController.text,
        double.parse(
          amountController.text,
        ),
        _pickedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((datePicked) {
      if (datePicked == null) {
        return;
      }
      setState(() {
        _pickedDate = datePicked;
      });
    });
  }
}
