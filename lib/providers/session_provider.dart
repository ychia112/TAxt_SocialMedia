import 'package:flutter/material.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class Session with ChangeNotifier{
  var _session;
  var _uri;

  dynamic get session => _session;
  dynamic get uri => _uri;

  void setSession(dynamic session){
    _session = session;
    notifyListeners();
  }

  void setUrl(dynamic uri){
    _uri = uri;
    notifyListeners();
  }
}