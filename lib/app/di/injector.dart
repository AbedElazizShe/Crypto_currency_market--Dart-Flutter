import 'package:crypto_currency_market/app/data/coin_data.dart';
import 'package:crypto_currency_market/app/data/coin_data_impl.dart';

class Injector {

  static final Injector _singleton = new Injector._internal();

  factory Injector(){
    return _singleton;
  }

  Injector._internal();

  CoinRepository get coinRepository{
    return new RemoteCoinRepository();
  }
}