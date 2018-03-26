import 'package:crypto_currency_market/values/dimens.dart';
import 'package:flutter/material.dart';
import 'package:crypto_currency_market/app/data/coin_data.dart';
import 'package:crypto_currency_market/values/strings.dart';
import 'package:crypto_currency_market/app/presenter/coin_presenter.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

/*
 * Stateful widgets maintain state that might change during the lifetime of the
 * widget
 */
class HomePage extends StatefulWidget {

  @override
  HomePageState createState() {
    HomePageState state = new HomePageState();
    new CoinsListPresenter(state);

    return state;
  }
}

class HomePageState extends State<HomePage>
    implements CoinsListViewContract{

  CoinsListPresenter _presenter;
  List _coins;
  bool _isLoading;
  bool _isError = false;

  @override
  void setPresenter(CoinsListPresenter presenter) {
    _presenter = presenter;

  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadCoins();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    Widget widget;

    if(_isLoading){
      widget = showProgressBar();
    }else{
      if(_isError || _coins == null || _coins.isEmpty){
        widget = new Center(
          child: new Text("Error fetching coins"),
        );
      }else{
        widget =  new Scaffold(
          appBar: new AppBar(
              title: new Text(Strings.HOME_TITLE)
          ),

          body:  new ListView.builder(
              itemCount: _coins == null ? 0 : _coins.length,
              itemBuilder: _rowBuilder
          ),
        );
      }
    }

   return widget;

  }

  Coin getCoin(int index){
    return new Coin(
        _coins[index]["id"],
        _coins[index]["name"],
        _coins[index]["symbol"],
        _coins[index]["rank"],
        _coins[index]["price_usd"],
        _coins[index]["price_btc"],
        _coins[index]["24h_volume_usd"],
        _coins[index]["market_cap_usd"],
        _coins[index]["available_supply"],
        _coins[index]["total_supply"],
        _coins[index]["max_supply"],
        _coins[index]["percent_change_1h"],
        _coins[index]["percent_change_24h"],
        _coins[index]["percent_change_7d"],
        _coins[index]["last_updated"]);
  }

  Widget _rowBuilder(BuildContext context, int index){
    Coin coin =  getCoin(index);
    return new CoinRowWidget(coin: coin);
  }

  /*
    Widget to show a progress bar to indicate that the data is being loaded
    a) the bar will be displayed at the centre of the screen
    b) the style will be determined based on the platform Android/iOS

    import dart:io
    import package:flutter/cupertino.dart
   */
  Widget showProgressBar(){
    return new Center(
      child: Platform.isAndroid ? new CircularProgressIndicator() :
      new CupertinoActivityIndicator(),
    );
  }

  @override
  void onLoadCoinsError() {
    setState((){
      _isError = true;
    });
  }

  @override
  void onLoadCoinsComplete(List coins) {
    setState((){
      _coins = coins;
      _isLoading = false;
    });
  }

}


class CoinRowWidget extends StatefulWidget{

  CoinRowWidget({Key key, this.coin}) : super(key: key);

  final Coin coin;

  @override
  CoinRowWidgetState createState() => new CoinRowWidgetState();
}

class CoinRowWidgetState extends State<CoinRowWidget>{

  @override
  Widget build(BuildContext context) {

    return new Card(
      child: new Padding(
          padding: new EdgeInsets.all(
              Dimens.padding_16
          ),

        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // This row include the icon and a column of texts
            new Row(
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.only(
                      right: Dimens.padding_08
                  ),
                  // Crypto image icon
                  child: new Image(
                      image: new NetworkImage(Strings.COIN_SMALL_ICON_BASE_URL +
                          getIconIndex(widget.coin.name).toString() + ".png", scale: 1.0)
                  ),
                ),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      widget.coin.rank + ". " + widget.coin.name + " (" + widget
                    .coin.symbol + ")",
                      overflow: TextOverflow.ellipsis,
                      style: new TextStyle(
                        fontSize: Dimens.textSize_14,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    new Padding(
                        padding: new EdgeInsets.only(
                          top: 5.0,
                          bottom: 5.0
                        ),
                      child: new Row(
                        textBaseline: TextBaseline.alphabetic,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: <Widget>[
                          new Text(
                            widget.coin.priceUsd + " USD",
                            style: new TextStyle(
                              fontSize: Dimens.textSize_14
                            ),
                          ),
                          new Padding(
                              padding: new EdgeInsets.only(
                                left: 5.0
                              ),
                            child: new Row(
                              children: <Widget>[
                                new Text(
                                (double.parse(widget.coin.percentChange1h).isNegative ? "" : "+")
                                + widget.coin.percentChange1h + "%",
                                  style: new TextStyle(
                                    fontSize: Dimens.textSize_12,
                                    color: double.parse(widget.coin.percentChange1h).isNegative ? Colors.red : Colors.green
                                  ),
                                ),
                                new Icon(
                                  getIcon(double.parse(widget.coin.percentChange1h).isNegative),
                                  color: double.parse(widget.coin.percentChange1h).isNegative ? Colors.red : Colors.green,
                                  size: Dimens.iconSize,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    new Text(
                      "last updated: " + new DateTime.fromMillisecondsSinceEpoch(
                        int.parse(widget.coin.lastUpdated) * 1000).toString(),
                      style: new TextStyle(
                        fontSize: 10.0
                      ),

                    )
                  ],
                )
              ],
            )
          ],

        ),
      ),
    );
  }

  // this is a bad practise, however, coinmarketcap is not returning icon image
  // anymore, this is ok for the purpose of the app.
  // the method will change when coinmarketcap API provides a mean to fetch the image
  int getIconIndex(String name){
    switch(name){
      case "Bitcoin":
        return 1;
      case "Ethereum":
        return 1027;
      case "Ripple":
        return 52;
      case "Bitcoin Cash":
        return 1831;
      case "Litecoin":
        return 2;
      case "EOS":
        return 1765;
      case "Cardano":
        return 2010;
      case "Stellar":
        return 512;
      case "NEO":
        return 1376;
      case "IOTA":
        return 1720;
      case "Dash":
        return 131;
      case "Monero":
        return 328;
      case "TRON":
        return 1958;
      case "NEM":
        return 873;
      case "Tether":
        return 825;
      default:
        return 0;


    }
  }

  IconData getIcon(bool isNegative){
      IconData icon;
      isNegative ? icon = Icons.arrow_drop_down : icon = Icons.arrow_drop_up;
      return icon;
  }
}