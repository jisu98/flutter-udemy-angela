import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<List<double>> getData(String money) async {
    List<double> price = [];

    for (String coin in cryptoList) {
      String url =
          'https://apiv2.bitcoinaverage.com/indices/global/ticker/$coin$money';
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        price.add(data['last']);
      } else {
        print(response.statusCode);
        return null;
      }
    }

    return price;
  }
}
