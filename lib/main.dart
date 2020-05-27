import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transactions.dart';
import './widgets/chart.dart';
//import 'package:flutter/services.dart';

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

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
        backgroundColor: Color.fromRGBO(255, 140, 0, 0.3),
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
      date: DateTime.now().add(Duration(days: -1)),
    ),
    Transaction(
      id: 'id_2',
      title: 'shoes',
      amount: 40.99,
      date: DateTime.now().subtract(Duration(days: 6)),
    ),
    Transaction(
      id: 'id_3',
      title: 'milk',
      amount: 20.01,
      date: DateTime.now().add(Duration(days: 4)),
    ),
    Transaction(
      id: 'id_4',
      title: 'tee',
      amount: 120.01,
      date: DateTime.now().add(Duration(days: 3)),
    ),
    Transaction(
      id: 'id_5',
      title: 'sugar',
      amount: 3.01,
      date: DateTime.now().add(Duration(days: -1)),
    ),
    Transaction(
      id: 'id_6',
      title: 'honey',
      amount: 75.01,
      date: DateTime.now().add(Duration(days: -2)),
    ),
    Transaction(
      id: 'id_7',
      title: 'bread',
      amount: 50.01,
      date: DateTime.now().add(Duration(days: -4)),
    ),
    Transaction(
      id: 'id_8',
      title: 'cucumber',
      amount: 50.01,
      date: DateTime.now().add(Duration(days: -3)),
    ),
    Transaction(
      id: 'id_10',
      title: 'onion',
      amount: 20.01,
      date: DateTime.now().add(Duration(days: -3)),
    ),
  ];
  bool _showChart = false;

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
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Center(
        child: Text(
          'Your personal expenses',
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => startAddingNewTransaction(context),
        ),
      ],
    );
    final showSwitch = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Show chart",
            style: Theme.of(context).textTheme.headline6,
          ),
          Switch(
            value: _showChart,
            onChanged: (value) {
              setState(() {
                _showChart = value;
              });
            },
          ),
        ],
      ),
    );
    final smallTransactionList = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.75,
      child: TransactionList(_recentTransaction, _deleteTransaction),
    );
    final smallChart = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.25,
      child: Chart(_recentTransaction),
    );
    final expandedTransactionList = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.9,
      child: TransactionList(_recentTransaction, _deleteTransaction),
    );
    final expandedChart = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.65,
      child: Chart(_recentTransaction),
    );
    final fillTheGap = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.25,
      child: null,
    );
    return Scaffold(
      appBar: appBar,
      body: Container(
        color: Theme.of(context).primaryColorLight,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isLandscape) showSwitch,
              if (isLandscape && _showChart) expandedChart,
              if (isLandscape && !_showChart) expandedTransactionList,
              if (!isLandscape) smallChart,
              if (!isLandscape) smallTransactionList,
              if (isLandscape) fillTheGap,
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddingNewTransaction(context),
      ),
    );
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime pickedDate) {
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

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
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
