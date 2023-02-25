import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'home.dart';
import '../providers/metamask_provider.dart';
import '../utils/blockchain.dart';

class UserPost extends StatefulWidget {
  const UserPost({Key? key}) : super(key: key);
  @override
  _UserPostState createState() => _UserPostState();
}
final List _userpost = <String>["hello world",];
class _UserPostState extends State<UserPost> {

  int timecount=1;
  var chosenmood=chose();
  final _textController = TextEditingController();
  // store the input text
  String userPost = '';
  Icon updateicon(int num){
    if(num==1)
    {
      return const Icon(Icons.insert_emoticon,color: Colors.black,size: 30,);
    }
    else if (num==2){
      return const Icon(Icons.emoji_emotions_rounded,color: Colors.black,size: 30,);
    }
    else if (num==3){
      return const Icon(Icons.favorite_border_outlined,color: Colors.black,size: 30,);
    }
    else if (num==4){
      return const Icon(Icons.favorite_outlined,color: Colors.black,size: 30,);
    }
    else{
      return const Icon(Icons.add_circle,size: 30,);
    }
  }
  // void affirming(var mood){
  //   if(mood==null)
  // }
  Future<String> uploadToIPFS(BuildContext context, String msg) async {
    http.Response res = await http.post(Uri.parse("${dotenv.env['backend_address']}/api/post"), body: jsonEncode({
      "author": context.read<MetaMask>().session.accounts[0],
      "title": "test_post",
      "context": msg,
      "emotion": "exciting"
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

  void post(BuildContext context, String msg) async {
    final cid = await uploadToIPFS(context, msg);
    postWithMetamask(context, cid);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        FocusScope.of(context).unfocus(),
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Colors.black,
                ),
                title: const Text('Y o u r t e x t'),
                centerTitle: true
            ),
          ),
          body:
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height-275,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey.shade50,
                          child:
                          ListView.separated(
                              itemCount: _userpost.length,
                              padding: const EdgeInsets.only(top:5.0,bottom:15 ),
                              separatorBuilder: (BuildContext context,int index)=>
                                const Divider(height: 16,color: Color(0xFFFFFFFF)),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24.0),
                                      color:  Colors.grey.shade200,
                                    ),
                                    child:
                                    Column(
                                      children: [
                                        Row(
                                            children: [
                                              Center(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: MediaQuery.of(context).size.width-24,
                                                    constraints: const BoxConstraints(
                                                        maxHeight: 250, minHeight: 200
                                                    ),//should be more precise
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(24.0),
                                                      color:  Colors.grey.shade300,),
                                                    child:
                                                    Text(
                                                        _userpost[index], textAlign: TextAlign.center,
                                                        maxLines: 10),
                                                  )
                                              ),
                                            ]
                                        ),
                                        Row(
                                            children:[
                                              SizedBox(
                                                height:40,
                                                width:45,
                                                child:updateicon(chosenmood[index]),
                                              )
                                            ]
                                        )
                                      ],
                                    ),
                                  );

                              }
                          ),
                        ),
                        // const Divider(
                        //   height: 5,
                        // ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              SizedBox(
                                width: MediaQuery.of(context).size.width-80,
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
                                width: 40,
                                height: 60,
                                child: IconButton(
                                  icon: const Icon(Icons.send_rounded),
                                  onPressed: (){
                                    setState(() {
                                      post(context, _textController.text);
                                      userPost=_textController.text;
                                      _textController.clear();
                                      _userpost.add(userPost) ;
                                      timecount++;
                                    });
                                  },
                                  color: Colors.black45,
                                  alignment: Alignment.centerRight,
                                ),
                              ),
                            ]
                        ),
                        // display text
                        // input text
                        // send text
                      ],
                    ),
                  ),)

                ],
              )

          )
      );


  }

}

List store()=> _userpost;


