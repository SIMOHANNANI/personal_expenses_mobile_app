import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 1000,
        child: transactions.isEmpty
            ? Column(
                children: <Widget>[
                  SizedBox(
                    height: 300.0,
                  ),
                  Container(
                    height: 200,
                    width: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (tx, index) {
                  return Card(
                      elevation: 5.0,
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              '\$${transactions[index].amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
//                          color: Colors.purpleAccent,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            margin: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            decoration: BoxDecoration(
                              border: Border.all(
//                          color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                transactions[index].title,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                DateFormat.yMMMMd()
                                    .format(transactions[index].date),
                                style: TextStyle(color: Colors.green),
                              )
                            ],
                          ),
                        ],
                      ));
                },
                itemCount: transactions.length,
              ));
  }
}
