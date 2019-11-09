import 'package:blockchain_prac/api_key.dart';
import 'package:dio/dio.dart';

class CurrencyCompare {

  Future<Map<String, dynamic>> getCurrency(String fsym, String tsym) async {

    Map<String, dynamic> _map = {};
    _map.putIfAbsent('fsym', ()=>fsym);
    _map.putIfAbsent('tsyms', ()=>tsym);
    _map.putIfAbsent('api_key', ()=>API_KEY);

    Response response =
        await Dio().get("https://min-api.cryptocompare.com/data/price", queryParameters: _map);
    return response.data;

  }
}

CurrencyCompare currencyCompare = new CurrencyCompare();