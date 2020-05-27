import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTransaction;

  TransactionList(this.transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
//              Text("${MediaQuery.of(context).size.width}"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.17,
                ),

                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (tx, index) {
              return Card(
                color: Colors.transparent,
                elevation: 0,
                margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 25.0),
                child: ListTile(
                  leading: Container(
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        border: new Border.all(
                          width: 1.0,
                          color: Colors.black,
                        ),
                      ),

                    child: CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Theme.of(context).backgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: FittedBox(
                            child: Text(
                                '\$${transactions[index].amount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
//                          color: Colors.purpleAccent,
                                  color: Colors.black,
                                )),
                          ),
                        )),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMMd().format(transactions[index].date),
                    style: TextStyle(color: Colors.green),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          icon: Icon(Icons.delete),
                          label: Text('delete',style: TextStyle(fontWeight: FontWeight.bold),),
                          textColor: Colors.red,
                          onPressed: () =>
                              _deleteTransaction(transactions[index].id),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () =>
                              _deleteTransaction(transactions[index].id),
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
