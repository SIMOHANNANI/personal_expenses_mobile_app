import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionsValue {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalAmount = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          totalAmount += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalAmount
      };
    });
  }

  double get totalSpending {
    return groupedTransactionsValue.fold(
        0.0, (previousValue, element) => previousValue + element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      margin: EdgeInsets.only(top:10.0,left:20.0,right:20.0,bottom:10.0),
      child: Padding(
        padding: const EdgeInsets.only(top:20.0,bottom: 0.0,left: 10.0,right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValue.map((singleChart) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(singleChart['day'], singleChart['amount'],
                  totalSpending == 0 ? 0.0 : (singleChart['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}