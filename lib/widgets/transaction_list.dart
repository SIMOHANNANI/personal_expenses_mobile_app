import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTransaction;
  TransactionList(this.transactions,this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        child: transactions.isEmpty
            ? Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 110.0,
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      child: Image.asset(
                        'assets/images/waiting.png',
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemBuilder: (tx, index) {
                  return Card(
                    color: Colors.white,
                    elevation: 6,
                    margin:
                        EdgeInsets.symmetric(vertical: 6.0, horizontal: 25.0),
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.grey,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: FittedBox(
                              child: Text(
                                  '\$${transactions[index].amount.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0,
//                          color: Colors.purpleAccent,
                                    color: Theme.of(context).primaryColorDark,
                                  )),
                            ),
                          )),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMMd().format(transactions[index].date),
                        style: TextStyle(color: Colors.green),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed:() => _deleteTransaction(transactions[index].id),
                      ),
                    ),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
