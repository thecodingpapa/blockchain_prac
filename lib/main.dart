import 'package:blockchain_prac/cached_currency.dart';
import 'package:blockchain_prac/color.dart';
import 'package:blockchain_prac/currency.dart';
import 'package:blockchain_prac/is_from_selected.dart';
import 'package:blockchain_prac/is_updating.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: darkColor,
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider<CachedCurrency>.value(value: cachedCurrency),
        ChangeNotifierProvider<IsFromSelected>.value(value: isFromSelected),
        ChangeNotifierProvider<IsUpdating>.value(value: isUpdating),
      ], child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double iconSize = 100;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: darkColor,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            height: size.height / 2,
            child: Container(
              color: lightColor,
              child: SafeArea(
                child: Column(),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            height: size.height / 2,
            child: Container(
              color: darkColor,
              child: SafeArea(
                child: Column(),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            height: size.height / 2,
            child: new Currency(
              isFromCurrency: true,
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            height: size.height / 2,
            child: new Currency(
              isFromCurrency: false,
            ),
          ),
          Positioned(
            height: iconSize,
            width: iconSize,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(iconSize / 2),
                color: lightColor,
              ),
            ),
          ),
          Positioned(
            height: iconSize,
            width: iconSize,
            child: Consumer<IsFromSelected>(
              builder: (context, isFromSelected, child) {
                return Transform.rotate(
                  angle: isFromSelected.value ? math.pi : 0,
                  child: Image.asset(
                    'assets/scroll_up.png',
                    color: darkColor,
                  ),
                );
              },
            ),
          ),
          Positioned(
            height: iconSize,
            width: iconSize,
            child: Consumer<IsUpdating>(
              builder: (context, isUpdating, child) {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Visibility(
                    visible: isUpdating.value,
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                      valueColor: new AlwaysStoppedAnimation<Color>(lightColor),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
