import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
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


class UserPost extends StatefulWidget {
  UserPost({Key? key}) : super(key: key);
  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  final List _userpost = <String>[];
  Mood _usermood = Mood.none; //temporarily store the input emotion (default: none)
  final _textController = TextEditingController();

  Future<String> uploadToIPFS(BuildContext context, String msg, Mood mood) async {
    http.Response res = await http.post(
      Uri.parse("${dotenv.env['backend_address']}/api/post"),
      body: jsonEncode({
        "author": context.read<MetaMask>().session.accounts[0],
        "context": msg,
        "mood": mood.index
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      }
    );
    print(res.body);
    return res.body;
  }

  void postWithMetamask(BuildContext context, String cid) async {
    var metamask = context.read<MetaMask>();
    var connector = metamask.connector;
    var session = metamask.session;
    if (connector.connected) {
      try {
        print("CID received");
        print(cid);

        EthereumWalletConnectProvider provider =
            EthereumWalletConnectProvider(connector);
        launchUrlString('wc:', mode: LaunchMode.externalApplication);
        final contract = await Blockchain.getContract();
        final function = contract.function("post");
        var signature = await provider.sendTransaction(
          from: session.accounts[0],
          to: dotenv.env['contract_address'],
          data: Transaction.callContract(
            contract: contract,
            function: function,
            parameters: [EthereumAddress.fromHex(session.accounts[0]), cid]
          ).data,
          gas: 300000
        );
        print(signature);
      } catch (exp) {
        print("Error while signing transaction");
        print(exp);
      }
    }
  }

  void post(BuildContext context, String msg, Mood mood) async {
    final cid = await uploadToIPFS(context, msg, mood);
    postWithMetamask(context, cid);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        FocusScope.of(context).unfocus(),
      },
      child: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: Colors.transparent,
            ),
            title: Text(
              dotenv.env['app_name']?? "load failed",
              style: GoogleFonts.abrilFatface(
                  textStyle: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )),
            ),
        ),
      ),
      body:
        SafeArea(
          child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    SizedBox(
                      width: 48,
                      height: 60,
                      child:
                        Row(
                          children: [
                            PopupMenuButton<int>(
                                offset: const Offset(5,-55),
                                color: Colors.black12,
                                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),side: const BorderSide(
                                //   style: BorderStyle.none,
                                // )),
                                icon:Text(
                                  moodEmoji[_usermood.index], // Replace with desired emoji//happy
                                  style: const TextStyle(fontSize: 20.0, color: Colors.white)
                                ),
                                onSelected: (int value) {
                                  setState(() {
                                    _usermood = Mood.values[value];
                                  });
                                },
                                itemBuilder: (BuildContext int) {
                                  return [
                                    PopupMenuWidget(
                                      height: 40.0,
                                      width: 380,
                                      child:Row(
                                          children: [
                                            for(var i = 1; i < Mood.values.length; i++)
                                              emojiSizedBox(Mood.values[i])
                                          ]
                                      ),
                                    ),
                                  ];
                                }
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width-105,
                      height: 80,
                      child:
                      TextFormField(
                        minLines: 1,
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: 'How is your day?',
                          //contentPadding: const EdgeInsets.all(18.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide:
                            const BorderSide( width: 3,color: Colors.black12),
                          ),
                          prefixIconConstraints: const BoxConstraints(
                              minWidth: 8
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              _textController.clear();
                            },
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 60,
                      child: IconButton(
                        icon: const Icon(Icons.send_rounded,size: 28,),
                        onPressed: (){
                          setState(() {
                            post(context, _textController.text, _usermood);
                            _textController.clear();
                            _usermood = Mood.none;
                          });
                        },
                        color: Colors.black45,
                        alignment: Alignment.center,
                      ),
                    ),
                  ]
                ),
              ],
            )
        )
      )
    );
  }

  Widget emojiSizedBox(Mood mood){
    return SizedBox(
      height: 40,
      width: 35,
      child: RawMaterialButton(
        onPressed: () {
          setState(() {
            _usermood = mood;
          });
        },
        fillColor: Colors.white,
        shape: const CircleBorder(),
        child: Text(
          moodEmoji[mood.index], //happy
          style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white),
        ),
      ),
    );
  }
}
class PopupMenuWidget<int> extends PopupMenuEntry<int> {
  const PopupMenuWidget({ Key? key, required this.height,required this.width, required this.child }) : super(key: key);

  final Widget child;
  final double width;
  @override
  final double height;


  @override
  bool get enabled => false;

  @override
  _PopupMenuWidgetState createState() =>  _PopupMenuWidgetState();

   @override
  bool represents(int? value) => false;
  // bool represents(int? value) {
  //   // TODO: implement represents
  //   throw UnimplementedError();

}

class _PopupMenuWidgetState extends State<PopupMenuWidget> {
  @override
  Widget build(BuildContext context) => widget.child;
}