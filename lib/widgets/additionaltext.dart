import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../providers/metamask_provider.dart';
import '../utils/blockchain.dart';
import '../utils/mood.dart';
import 'package:google_fonts/google_fonts.dart';


class extratext extends StatefulWidget {
  extratext({Key? key}) : super(key: key);
  @override
  _ExtraText createState() => _ExtraText();
}

class _ExtraText extends State<extratext> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child:
          Text("the page for the additional text",style: TextStyle(color: Colors.black54),))
    );
  }
  
}