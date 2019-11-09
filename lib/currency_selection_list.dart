import 'package:blockchain_prac/cached_currency.dart';
import 'package:blockchain_prac/color.dart';
import 'package:blockchain_prac/currency_code.dart';
import 'package:blockchain_prac/currency_server.dart';
import 'package:blockchain_prac/is_updating.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencySelectionList extends StatelessWidget {
  final bool isFromCurrency;
  final List<String> currencies;

  CurrencySelectionList(
    this.isFromCurrency, {
    Key key,
  })  : currencies = nameToCode.keys.toList(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Currency"),
      ),
      body: ListView.builder(
          itemCount: currencies.length,
          itemBuilder: (context, index) => Container(
                color: isFromCurrency ? darkColor : lightColor,
                child: ListTile(
                  onTap: () {
                    isUpdating.set(true);
                    if (isFromCurrency) {
                      cachedCurrency.fsym = nameToCode[currencies[index]];
                    } else {
                      cachedCurrency.tsym = nameToCode[currencies[index]];
                    }
                    currencyCompare
                        .getCurrency(cachedCurrency.fsym, cachedCurrency.tsym)
                        .then((conversion) {
                      isUpdating.set(false);
                      cachedCurrency.setNewConversion(conversion, isFromCurrency);
                    });
                    Navigator.of(context).pop();
                  },
                  title: Text(
                    currencies[index],
                    textScaleFactor: 1.5,
                    style: TextStyle(color: isFromCurrency ? lightColor : darkColor),
                  ),
                  subtitle: Opacity(
                      opacity: 0.5,
                      child: Text(
                        nameToCode[currencies[index]],
                        style: TextStyle(color: isFromCurrency ? lightColor : darkColor),
                      )),
                ),
              )),
    );
  }
}
