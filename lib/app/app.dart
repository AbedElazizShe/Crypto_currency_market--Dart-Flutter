import 'package:flutter/material.dart';
import 'package:crypto_currency_market/values/strings.dart';
import 'package:crypto_currency_market/app/ui/home.dart';

final _appTheme = new ThemeData(

  // This is the theme of your application, here, the look and the feel of
  // the app can be controlled, click ctrl-space to view all suggestions
  primaryColor: Colors.white,
  accentColor: Colors.cyan,

);

class CryptoApp extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: Strings.APP_NAME,
      theme: _appTheme,
      home: new HomePage(),
    );

  }
}