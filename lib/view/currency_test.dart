import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyTest extends StatelessWidget {
  const CurrencyTest({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 20,
      child: ElevatedButton(
        onPressed: () {
          currency(context);
        },
        child: const Text('Galeri'),
      ),
    );
  }

  void currency(BuildContext context) {
    var nama = NumberFormat.simpleCurrency(
      name: "MYR", //currencyCode
    ).format(10000);

    print(nama);
    // var format = NumberFormat.simpleCurrency(locale: "");
    // print("CURRENCY SYMBOL ${format.currencySymbol}"); // $
    // print("CURRENCY NAME ${format.currencyName}"); // USD
  }
}
