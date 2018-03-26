import 'dart:async';
import 'dart:convert';
import 'package:crypto_currency_market/app/data/coin_data.dart';
import 'package:http/http.dart' as http;
import 'package:crypto_currency_market/values/strings.dart';

class RemoteCoinRepository implements CoinRepository{

  @override
  Future<List> fetch() async {

    http.Response response = await http.get(
        Uri.encodeFull(Strings.COIN_URL)
    );

    final String jsonBody = response.body;
    final statusCode = response.statusCode;

    if(jsonBody == null || statusCode < 200 || statusCode >= 300){
      throw new FetchDataException("Error while fetching data ["
          "StatusCode: $statusCode, Error: $response]");
    }

  return json.decode(jsonBody);

  }
}