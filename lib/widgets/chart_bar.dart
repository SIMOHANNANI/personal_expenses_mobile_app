import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  '\$${spendingAmount.toStringAsFixed(0)}',
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.08,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 15.0,
              child: Stack(
                children: <Widget>[
                  Container(
//                height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey, width: 2.0),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                        border: Border.all(color: Colors.blueGrey, width: 2.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.07,
            ),
            Container(
              height: constraints.maxHeight * 0.10,
              child: FittedBox(child: Text(label)),
            ),
          ],
        );
      },
    );
  }
}
