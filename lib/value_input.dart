import 'package:blockchain_prac/cached_currency.dart';
import 'package:blockchain_prac/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class ValueInput extends StatefulWidget {
  final bool isFromCurrency;

  const ValueInput(
    this.isFromCurrency, {
    Key key,
  }) : super(key: key);

  @override
  _ValueInputState createState() => _ValueInputState();
}

class _ValueInputState extends State<ValueInput> {
  GlobalKey<FormState> _formKey = new GlobalKey();
  var _currencyInputController = new MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: '');

  @override
  void initState() {
    _currencyInputController.value = TextEditingValue(
        text: (widget.isFromCurrency
                ? cachedCurrency.fvalue
                : cachedCurrency.tvalue)
            .toStringAsFixed(2));
    super.initState();
  }

  @override
  void dispose() {
    _currencyInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: widget.isFromCurrency?darkColor:lightColor,
      appBar: AppBar(
        title: Text(
            widget.isFromCurrency ? cachedCurrency.fsym : cachedCurrency.tsym),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: TextFormField(
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: widget.isFromCurrency?lightColor:darkColor, fontSize: 60),
                      controller: _currencyInputController,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(20),
                        BlacklistingTextInputFormatter.singleLineFormatter,
                      ],
                      decoration: InputDecoration(border: InputBorder.none),
                      enabled: false,
                    ),
                  ),
                ),
              ),
            ),
            GridView.count(
              padding: EdgeInsets.all(30),
              crossAxisCount: 3,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              shrinkWrap: true,
              children: List.generate(12, (index) {
                Color oppositeColor = (widget.isFromCurrency?lightColor:darkColor);
                Color cccc = Color.fromRGBO(oppositeColor.red, oppositeColor.green, oppositeColor.blue, 0.20);
                return SizedBox(
                  width: (size.width - 120) / 3,
                  height: (size.width - 120) / 3,
                  child: FlatButton(
                    onPressed: () {
                      if (index < 9) {
                        _currencyInputController.text =
                            _currencyInputController.text + inputButton(index);
                      } else {
                        switch (index) {
                          case 9:
                            _currencyInputController.text =
                                _currencyInputController.text.substring(0, _currencyInputController.text.length-1);
                            break;
                          case 10:
                            _currencyInputController.text =
                                _currencyInputController.text + inputButton(index);
                            break;
                          case 11:
                            if (widget.isFromCurrency) {
                              cachedCurrency.setNewFvalue(
                                  double.parse(_currencyInputController.text));
                            } else {
                              cachedCurrency.setNewTvalue(
                                  double.parse(_currencyInputController.text));
                            }
                            Navigator.of(context).pop();
                            break;
                        }
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular((size.width - 120) / 6)),
                    color: cccc,
                    splashColor: widget.isFromCurrency?lightColor:darkColor,
                    child: getButtonContent(index),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget getButtonContent(int index) {
    if (index < 9) {
      return Text(
        inputButton(index),
        style: TextStyle(color: widget.isFromCurrency?lightColor:darkColor, fontSize: 24),
      );
    } else {
      switch (index) {
        case 9:
          return Icon(
            Icons.arrow_back_ios,
            color: widget.isFromCurrency?darkColor:lightColor,
          );
        case 10:
          return Text(
            inputButton(index),
            style: TextStyle(color: widget.isFromCurrency?lightColor:darkColor, fontSize: 24),
          );
        case 11:
          return Icon(
            Icons.done,
            color: widget.isFromCurrency?lightColor:darkColor,
          );
      }
    }
  }

  String inputButton(int index) {
    switch (index) {
      case 0:
        return '1';
      case 1:
        return '2';
      case 2:
        return '3';
      case 3:
        return '4';
      case 4:
        return '5';
      case 5:
        return '6';
      case 6:
        return '7';
      case 7:
        return '8';
      case 8:
        return '9';
      case 10:
        return '0';
      default:
        return '';
    }
  }
}
