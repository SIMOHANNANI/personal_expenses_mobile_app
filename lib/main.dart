import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transactions.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal expenses',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        errorColor: Colors.red,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'QuickSand',
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 'id_1',
      title: 'T-shirt',

     amount: 93.01,
      date: DateTime.now().add(Duration(days:-1)),
    ),
    Transaction(
      id: 'id_2',
      title: 'shoes',
      amount: 40.99,
      date: DateTime.now().subtract(Duration(days:6)),
    ),
    Transaction(
      id: 'id_3',
      title: 'milk',
      amount: 20.01,
      date: DateTime.now().add(Duration(days:4)),
    ),
    Transaction(
      id: 'id_4',
      title: 'tee',

      amount: 120.01,
      date: DateTime.now().add(Duration(days:3)),
    ),
    Transaction(
      id: 'id_5',
      title: 'sugar',

      amount: 3.01,
      date: DateTime.now().add(Duration(days:-1)),
    ),
    Transaction(
      id: 'id_6',
      title: 'honey',
      amount: 75.01,
      date: DateTime.now().add(Duration(days:-2)),
    ),
  ];

  // Keep only the transaction of last week
  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your personal expenses',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startAddingNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransaction),
            TransactionList(_recentTransaction,_deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddingNewTransaction(context),
      ),
    );
  }

  void _addNewTransaction(String txTitle, double txAmount,DateTime pickedDate) {
    final _newTransaction = Transaction(
      title: txTitle,
      amount: txAmount,
      date: pickedDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(_newTransaction);
    });
  }
  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx)=>tx.id == id );
    });
  }
  void startAddingNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }
}
