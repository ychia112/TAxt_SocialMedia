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


class UserPost extends StatefulWidget {
  UserPost({Key? key}) : super(key: key);
  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  Mood _usermood = Mood.none; //temporarily store the input emotion (default: none)
  final _textController = TextEditingController();

  Future<String> uploadToIPFS(String msg, Mood mood) async {
    http.Response res = await http.post(
      Uri.parse("${dotenv.env['backend_address']}/api/post"),
      body: jsonEncode({
        "author": context.read<MetaMask>().session.accounts[0],
        "context": msg,
        "mood": mood.index,
        "datetime": DateTime.now().toUtc().toString()
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      }
    );
    return res.body;
  }

  Future<bool> postWithMetamask(String cid) async {
    var metamask = context.read<MetaMask>();
    var connector = metamask.connector;
    var session = metamask.session;
    if (connector.connected) {
      try {
        EthereumWalletConnectProvider provider =
            EthereumWalletConnectProvider(connector);
        launchUrlString('wc:', mode: LaunchMode.externalApplication);
        final contract = await Blockchain.getContract('PostNFT');
        final function = contract.function("post");
        await provider.sendTransaction(
          from: session.accounts[0],
          to: dotenv.env['contract_address_PostNFT'],
          data: Transaction.callContract(
            contract: contract,
            function: function,
            parameters: [EthereumAddress.fromHex(session.accounts[0]), cid]
          ).data,
          gas: 300000
        );
        return true;
      } catch (exp) {
        print("Error while signing transaction");
        print(exp);
        return false;
      }
    }
    return false;
  }

  snackBar({String? label}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label!),
            const CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
        duration: const Duration(days: 1),
        backgroundColor: Colors.black,
      ),
    );
  }

  snackBarError({String? label}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.close, color: Colors.white),
            const SizedBox(width: 10,),
            Text(label!),
          ],
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  snackBarSuccess({String? label}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.done, color: Colors.white),
            const SizedBox(width: 10,),
            Text(label!),
          ],
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  void post(String msg, Mood mood) async {
    if(mood == Mood.none){
      snackBarError(label: "Please select a mood!");
      return;
    }

    snackBar(label: "Uploading");
    String cid = await uploadToIPFS(msg, mood);
    bool success = await postWithMetamask(cid);
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    if(success){
      snackBarSuccess(label: "Success");
    }
    else{
      snackBarError(label: "Transaction failed!");
    }
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
              dotenv.env['app_name']!,
              style: GoogleFonts.abrilFatface(
                  textStyle: const TextStyle(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:[
                    Container(
                      width: 48,
                      height: 60,
                      alignment: Alignment.bottomCenter,
                      child:
                        Row(
                          children: [
                            PopupMenuButton<int>(
                                offset: const Offset(5,-55),
                                color: Colors.black12,
                                constraints:const BoxConstraints(
                                  minWidth: 7.0 * 56.0,
                                  maxWidth: 8.0 * 56.0,
                                ),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),side: const BorderSide(
                                  style: BorderStyle.none,
                                )),
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
                                            const Padding(padding: EdgeInsets.only(left:16,right:16),),
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
                    Container(
                      width: MediaQuery.of(context).size.width-105,
                      height: 280,
                      alignment: Alignment.bottomCenter,
                      child:
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines:10,
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: 'How is your day?',
                          filled: true,
                          fillColor:Colors.black12,
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
                    Container(
                      width: 50,
                      height: 60,
                      alignment: Alignment.bottomCenter,
                      child: IconButton(
                        icon: const Icon(Icons.send_rounded,size: 28,),
                        onPressed: (){
                          post(_textController.text, _usermood);
                          if(!mounted)  return;
                          setState(() {
                            if(_usermood != Mood.none){
                              _textController.clear();
                              _usermood = Mood.none;
                            }
                          });
                        },
                        color: Colors.black45,
                        alignment: Alignment.center,
                      ),
                    ),
                  ]
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 10,
                    )
                  ],
                )
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
        //fillColor: Colors.transparent,
        shape: const CircleBorder(),
        child: Text(
          moodEmoji[mood.index],
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

}
class _PopupMenuWidgetState extends State<PopupMenuWidget> {
  @override
  Widget build(BuildContext context) => widget.child;
}