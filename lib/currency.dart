import 'package:blockchain_prac/cached_currency.dart';
import 'package:blockchain_prac/color.dart';
import 'package:blockchain_prac/currency_code.dart';
import 'package:blockchain_prac/currency_selection_list.dart';
import 'package:blockchain_prac/is_from_selected.dart';
import 'package:blockchain_prac/slide_transitions.dart';
import 'package:blockchain_prac/value_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Currency extends StatefulWidget {
  const Currency({
    Key key,
    @required this.isFromCurrency,
  }) : super(key: key);

  final isFromCurrency;

  @override
  _CurrencyState createState() => _CurrencyState();
}

class _CurrencyState extends State<Currency> {
  double gap = 100;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<CachedCurrency>(
      builder: (context, cachedCurrency, child) {
        return Container(
          color: backgroundColor,
          child: Column(
            verticalDirection: widget.isFromCurrency
                ? VerticalDirection.down
                : VerticalDirection.up,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                height: gap / 3,
              ),
              Flexible(
                  flex: 3,
                  child: FlatButton(
                    onPressed: (){
                      Provider.of<IsFromSelected>(context).set(widget.isFromCurrency);
                      Navigator.of(context).push(SlideRoute(
                        CurrencySelectionList(widget.isFromCurrency),
                        direction: widget.isFromCurrency
                            ? SlideRouteDirection.left
                            : SlideRouteDirection.right));},
                    child: Text(
                      codeToName[widget.isFromCurrency
                          ? cachedCurrency.fsym
                          : cachedCurrency.tsym],
                      maxLines: 1,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 30,
                      ),
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  Provider.of<IsFromSelected>(context).set(widget.isFromCurrency);
                  Navigator.of(context).push(SlideRoute(
                    ValueInput(widget.isFromCurrency),
                    direction: widget.isFromCurrency
                        ? SlideRouteDirection.top
                        : SlideRouteDirection.bottom));},
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: FittedBox(
                    child: Text(
                      (widget.isFromCurrency
                              ? cachedCurrency.fvalue
                              : cachedCurrency.tvalue)
                          .toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(color: textColor, fontSize: 60),
                    ),
                  ),
                ),
              ),
              Flexible(
                  flex: 2,
                  child: Opacity(
                      opacity: 0.5,
                      child: Text(
                        widget.isFromCurrency
                            ? cachedCurrency.fsym
                            : cachedCurrency.tsym,
                        style: TextStyle(color: textColor),
                        textScaleFactor: 1.5,
                      ))),
              SizedBox(
                height: gap / 2,
              )
            ],
          ),
        );
      },
    );
  }

  Color get textColor => widget.isFromCurrency ? lightColor : darkColor;

  Color get backgroundColor => widget.isFromCurrency ? darkColor : lightColor;
}
