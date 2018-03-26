import 'dart:async';
/*
Response body for each coin;
{
        "id": "bitcoin",
        "name": "Bitcoin",
        "symbol": "BTC",
        "rank": "1",
        "price_usd": "8943.29",
        "price_btc": "1.0",
        "24h_volume_usd": "6058770000.0",
        "market_cap_usd": "151475185717",
        "available_supply": "16937300.0",
        "total_supply": "16937300.0",
        "max_supply": "21000000.0",
        "percent_change_1h": "-0.16",
        "percent_change_24h": "3.13",
        "percent_change_7d": "11.79",
        "last_updated": "1521911368"
    }
 */

class Coin {

  String id;
  String name;
  String symbol;
  String rank;
  String priceUsd;
  String priceBtc;
  String volumeUsd24h;
  String marketCapUsd;
  String availableSupply;
  String totalSupply;
  String maxSupply;
  String percentChange1h;
  String percentChange24h;
  String percentChange7d;
  String lastUpdated;

  Coin(this.id,
      this.name,
      this.symbol,
      this.rank,
      this.priceUsd,
      this.priceBtc,
      this.volumeUsd24h,
      this.marketCapUsd,
      this.availableSupply,
      this.totalSupply,
      this.maxSupply,
      this.percentChange1h,
      this.percentChange24h,
      this.percentChange7d,
      this.lastUpdated){
    //e.g. 111.1111.toStringAsFixed(2) = 111.11
    this.priceUsd = double.parse(this.priceUsd).toStringAsFixed(2);
    this.percentChange1h = double.parse(this.percentChange1h).toStringAsFixed(1);
  }



}

abstract class CoinRepository {
  Future<List> fetch();
}

class FetchDataException implements Exception {

  String _message;

  FetchDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}