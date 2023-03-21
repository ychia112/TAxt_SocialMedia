import 'dart:convert';
import 'dart:io';
import 'package:ethereum_addresses/ethereum_addresses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ios_proj01/utils/user_info.dart';
import 'package:ios_proj01/widgets/profile_widget.dart';
import 'package:ios_proj01/widgets/textfield_widget.dart';
import 'package:ios_proj01/widgets/button_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import '../providers/metamask_provider.dart';
import '../utils/blockchain.dart';
import 'package:ios_proj01/widgets/textfield_widget.dart';
import '../utils/mood.dart';

class NewDiary extends StatefulWidget {
  @override
  State<NewDiary> createState() => _NewDiaryState();
}

class _NewDiaryState extends State<NewDiary> {
  Mood _usermood = Mood.none;
  final _textController_address = TextEditingController();
  final _textController_context = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title:Text(
              'New Diary',
              style: GoogleFonts.abrilFatface(
                textStyle: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                )
              ),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children:[
              const SizedBox(height: 12,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'To :',
                  style: GoogleFonts.abrilFatface(
                      textStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      )
                  ),
                ),
              ),
              const SizedBox(height: 12,),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines:3,
                  controller: _textController_address,
                  decoration: InputDecoration(
                    hintText: 'Send to',
                    hintStyle: GoogleFonts.merriweather(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black
                        )),
                    filled: true,
                    fillColor:Colors.white70,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.0),
                      borderSide:
                      const BorderSide( width: 2,color: Colors.black12),
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.0),
                      borderSide:
                      const BorderSide( width: 2,color: Colors.black12),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                        minWidth: 8
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _textController_address.clear();
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                ),
              const SizedBox(height: 12,),
              Container(
                alignment: Alignment.centerLeft,
                child: PopupMenuButton<int>(
                  elevation: 0,
                  offset: const Offset(45,-4),
                  color: Colors.transparent,
                  constraints: const BoxConstraints(
                    minWidth: 7.0 * 40.0,
                    maxWidth: 8.0 * 40.0,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                      side: const BorderSide(
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
                        width: 380.0,
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
              ),
              const SizedBox(height: 12,),
              TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 20,
                maxLines:50,
                controller: _textController_context,
                decoration: InputDecoration(
                  hintText: '',
                  hintStyle: GoogleFonts.merriweather(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black
                      )),
                  filled: true,
                  fillColor:Colors.white70,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide:
                    const BorderSide( width: 2,color: Colors.black12),
                  ),
                  focusedBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide:
                    const BorderSide( width: 2,color: Colors.black12),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                      minWidth: 8
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 5,)),
              OutlinedButton(
                onPressed: (){
                  newDiary(_textController_address.text, _textController_context.text, Mood.fascinated);
                  setState(() {
                    _textController_address.clear();
                    _textController_context.clear();
                  });
                },
                style:OutlinedButton.styleFrom(
                  elevation: 3,
                  backgroundColor: Colors.white70,

                ),
                child: Text("Send",
                  style: GoogleFonts.abrilFatface(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),),),),
              const Padding(padding: EdgeInsets.only(bottom: 5,)),
            ],
          ),

          ),
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

  void newDiary(String to, String msg, Mood mood) async {
    if(mood == Mood.none){
      snackBarError(label: "Please select a mood!");
      return;
    }

    final to_address = to.toLowerCase();
    if(!isValidEthereumAddress(to_address)){
      snackBarError(label: "Please ensure the address is valid!");
      return;
    }

    snackBar(label: "Uploading");
    String cid = await uploadToIPFS(msg, mood);
    bool success = await newDiaryWithMetamask(to_address, cid);
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    if(success){
      snackBarSuccess(label: "Success");
    }
    else{
      snackBarError(label: "Transaction failed!");
    }
  }

  Future<String> uploadToIPFS(String msg, Mood mood) async {
    http.Response res = await http.post(
      Uri.parse("${dotenv.env['backend_address']}/api/post"),
      body: jsonEncode({
        "author": context.read<MetaMask>().getAddress(),
        "context": msg,
        "mood": mood.index,
        "datetime": DateTime.now().toUtc().toString()
      }),
      headers: {'Content-Type': 'application/json'}
    );
    return res.body;
  }

  Future<bool> newDiaryWithMetamask(String to, String cid) async {
    var metamask = context.read<MetaMask>();
    var connector = metamask.connector;
    if (connector.connected) {
      try {
        EthereumWalletConnectProvider provider =
            EthereumWalletConnectProvider(connector);
        launchUrlString('wc:', mode: LaunchMode.externalApplication);
        final contract = await Blockchain.getContract('DiaryNFT');
        final function = contract.function("newDiary");
        await provider.sendTransaction(
          from: metamask.getAddress(),
          to: dotenv.env['contract_address_DiaryNFT'],
          data: Transaction.callContract(
            contract: contract,
            function: function,
            parameters: [EthereumAddress.fromHex(to), cid]
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
