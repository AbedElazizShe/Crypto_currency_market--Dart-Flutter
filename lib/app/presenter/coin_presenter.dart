import 'package:crypto_currency_market/app/data/coin_data.dart';
import 'package:crypto_currency_market/app/di/injector.dart';

abstract class CoinsListViewContract {
  void setPresenter(CoinsListPresenter presenter);
  void onLoadCoinsComplete(List coins);
  void onLoadCoinsError();
}


abstract class CoinListPresenterContract {
  void loadCoins();
}

class CoinsListPresenter implements CoinListPresenterContract {

  CoinsListViewContract _view;
  CoinRepository _repository;

  CoinsListPresenter(this._view) {
    _repository = new Injector().coinRepository;
    _view.setPresenter(this);
  }

  @override
  void loadCoins() {
    _repository.fetch()
        .then((coins) => _view.onLoadCoinsComplete(coins))
        .catchError((onError) {
      print(onError);
      _view.onLoadCoinsError();
    });
  }


}