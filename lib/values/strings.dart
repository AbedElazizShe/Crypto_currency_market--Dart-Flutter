/*
In order to store strings, the best practice is to create a class that includes
all strings that are used within the app. This will help if it's decided to
support multiple languages
 */
class Strings{

  static const String APP_NAME = "Crypto Currency Market";
  static const String HOME_TITLE = "Crypto Market Cap";

  static const String COIN_SMALL_ICON_BASE_URL = "https://s2.coinmarketcap.com/static/img/coins/64x64/";
  static const String COIN_URL = "https://api.coinmarketcap.com/v1/ticker/?convert=USD&limit=15";

}