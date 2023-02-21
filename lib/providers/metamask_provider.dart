import 'package:flutter/material.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class MetaMask with ChangeNotifier{
  var _connector;
  var _session;
  var _uri;

  dynamic get connector => _connector;
  dynamic get session => _session;
  dynamic get uri => _uri;

  void setConnector(dynamic connector){
    _connector = connector;
    notifyListeners();
  }
  void setSession(dynamic session){
    _session = session;
    notifyListeners();
  }

  void setUrl(dynamic uri){
    _uri = uri;
    notifyListeners();
  }

}