import 'dart:convert';
import 'dart:core';
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
import '../utils/mood.dart';
int _usermood=-1; //temporarily store the input emotion//default -1

class UserPost extends StatefulWidget {
  UserPost({Key? key}) : super(key: key);
  @override
  _UserPostState createState() => _UserPostState();
}
class _UserPostState extends State<UserPost> {
  List chosenmood=<int>[]; //目前使用者曾經按過的表情符號 (本地)
  String userPost = '';// temporarily store the input text
  final List _userpost = <String>[];
  GlobalKey<_IconWidgetState> iconKey = GlobalKey();

  final _textController = TextEditingController();
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
                title: const Text('TAxt'),
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
                                                child:
                                                  updateicon(chosenmood[index])
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
                                          offset: const Offset(5,45),
                                          icon:updateiconpure(_usermood),
                                          onSelected: (int value) {
                                            setState(() {
                                              _usermood=-1;
                                              value=_usermood;
                                            });
                                          },
                                          itemBuilder: (BuildContext int) {
                                            return [
                                              PopupMenuWidget(
                                                height: 40.0,
                                                width: 380,
                                                child:Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 40,
                                                        width: 35,
                                                        child: RawMaterialButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              _usermood = Mood.happy.index;
                                                            });
                                                          },
                                                          fillColor: Colors.white,
                                                          shape: const CircleBorder(),
                                                          child: const Text(
                                                            '😄', //happy
                                                            style: TextStyle(
                                                                fontSize: 20.0,
                                                                color: Colors.white),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        width: 35,
                                                        child: RawMaterialButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              _usermood =
                                                                  Mood.angry.index;
                                                            });

                                                          },
                                                          fillColor: Colors.white,
                                                          shape: const CircleBorder(),
                                                          child: const Text(
                                                            '😡',
                                                            // Replace with desired emoji//angry
                                                            style: TextStyle(
                                                                fontSize: 20.0,
                                                                color: Colors.white),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        width: 35,
                                                        child: RawMaterialButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              _usermood =
                                                                  Mood.disappointed
                                                                      .index;
                                                            });
                                                          },
                                                          fillColor: Colors.white,
                                                          shape: const CircleBorder(),
                                                          child: const Text(
                                                            '😞',
                                                            // Replace with desired emoji//disappointed
                                                            style: TextStyle(
                                                                fontSize: 20.0,
                                                                color: Colors.white),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        width: 35,
                                                        child: RawMaterialButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              _usermood =
                                                                  Mood.peaceful.index;
                                                            });
                                                          },
                                                          fillColor: Colors.white,
                                                          shape: const CircleBorder(),
                                                          child: const Text(
                                                            '😌',
                                                            // Replace with desired emoji//peaceful,
                                                            style: TextStyle(
                                                                fontSize: 20.0,
                                                                color: Colors.white),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        width:35,
                                                        child: RawMaterialButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              _usermood =
                                                                  Mood.disgusted.index;
                                                            });

                                                          },
                                                          fillColor: Colors.white,
                                                          shape: const CircleBorder(),
                                                          child: const Text(
                                                            '🤢',
                                                            // Replace with desired emoji//disgusted,
                                                            style: TextStyle(
                                                                fontSize: 20.0,
                                                                color: Colors.white),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        width: 35,
                                                        child: RawMaterialButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              _usermood =
                                                                  Mood.fearful.index;
                                                            });
                                                          },
                                                          fillColor: Colors.white,
                                                          shape: const CircleBorder(),
                                                          child: const Text(
                                                            '😨',
                                                            // Replace with desired emoji//fearful,
                                                            style: TextStyle(
                                                                fontSize: 20.0,
                                                                color: Colors.white),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        width: 35,
                                                        child: RawMaterialButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              _usermood =
                                                                  Mood.shocked.index;
                                                            });

                                                          },
                                                          fillColor: Colors.white,
                                                          shape: const CircleBorder(),
                                                          child: const Text(
                                                            '😱',
                                                            // Replace with desired emoji//shocked,
                                                            style: TextStyle(
                                                                fontSize: 20.0,
                                                                color: Colors.white),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        width: 35,
                                                        child: RawMaterialButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              _usermood =
                                                                  Mood.fascinated.index;
                                                            });
                                                          },
                                                          fillColor: Colors.white,
                                                          shape: const CircleBorder(),
                                                          child: const Text(
                                                            '🤩',
                                                            // Replace with desired emoji//fascinated
                                                            style: TextStyle(
                                                                fontSize: 20.0,
                                                                color: Colors.white),
                                                          ),
                                                        ),
                                                      ),
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
                                width: MediaQuery.of(context).size.width-95,
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
                                width: 20,
                                height: 60,
                                child: IconButton(
                                  icon: const Icon(Icons.send_rounded),
                                  onPressed: (){
                                    setState(() {
                                      post(context, _textController.text);
                                      userPost=_textController.text;
                                      _textController.clear();
                                      _userpost.add(userPost) ;
                                      chosenmood.add(_usermood);
                                      _usermood=-1;
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

class IconWidget extends StatefulWidget {
  final Key key;
  const IconWidget(this.key);
  @override
  _IconWidgetState createState() => _IconWidgetState();
}
class _IconWidgetState extends State<IconWidget> {
  int iconnum = -1;
  void onPressed() {
    setState((){
      iconnum = _usermood;
    });
  }
  @override
  Widget build(BuildContext context) {
    return updateiconpure(iconnum);
  }
}

Widget updateicon(int num) {
  if (num == 0) {
    return RawMaterialButton(
      onPressed: () {},
      fillColor: Colors.white,
      shape: const CircleBorder(),
      child: const Text(
        '😄', // Replace with desired emoji//happy
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    );
  }
  else if (num == 1) {
    return RawMaterialButton(
      onPressed: () {
        // Handle button press
      },
      fillColor: Colors.white,
      shape: const CircleBorder(),
      child: const Text(
        '😡', // Replace with desired emoji//angry
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    );
  }
  else if (num == 2) {
    return RawMaterialButton(
      onPressed: () {
        // Handle button press
      },
      fillColor: Colors.white,
      shape: const CircleBorder(),
      child: const Text(
        '😞', // Replace with desired emoji//disappointed
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    );
  }
  else if (num == 3) {
    return RawMaterialButton(
      onPressed: () {
        // Handle button press
      },
      fillColor: Colors.white,
      shape: const CircleBorder(),
      child: const Text(
        '😌', // Replace with desired emoji//peaceful,
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    );
  }
  else if (num == 4) {
    return RawMaterialButton(
      onPressed: () {
        // Handle button press
      },
      fillColor: Colors.white,
      shape: const CircleBorder(),
      child: const Text(
        '🤢', // Replace with desired emoji//disgusted,
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    );
  }
  else if (num == 5) {
    return RawMaterialButton(
      onPressed: () {
        // Handle button press
      },
      fillColor: Colors.white,
      shape: const CircleBorder(),
      child: const Text(
        '😨', // Replace with desired emoji//fearful,
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    );
  }
  else if (num == 6) {
    return RawMaterialButton(
      onPressed: () {
        // Handle button press
      },
      fillColor: Colors.white,
      shape: const CircleBorder(),
      child: const Text(
        '😱', // Replace with desired emoji//shocked,
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    );
  }
  else if (num == 7) {
    return RawMaterialButton(
      onPressed: () {
        // Handle button press
      },
      fillColor: Colors.white,
      shape: const CircleBorder(),
      child: const Text(
        '🤩', // Replace with desired emoji//fascinated
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    );
  }
  else {
    return RawMaterialButton(
        onPressed: () {},
        fillColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.circle_outlined, size: 30,color: Colors.black45,)

    );
  }
}

Widget updateiconpure(int num){
  if(num==0){
      return const Text(
          '😄', // Replace with desired emoji//happy
          style: TextStyle(fontSize: 20.0, color: Colors.white));
    }
  else if(num==1){
      return const Text(
        '😡', // Replace with desired emoji//angry
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      );
    }
  else if (num==2){
    return const Text(
      '😞', // Replace with desired emoji//disappointed
      style: TextStyle(fontSize: 20.0, color: Colors.white),
    );
  }
  else if(num==3){
    return const Text(
      '😌', // Replace with desired emoji//peaceful,
      style: TextStyle(fontSize: 20.0, color: Colors.white),
    );
  }
  else if (num==4){
    return const Text(
      '🤢', // Replace with desired emoji//disgusted,
      style: TextStyle(fontSize: 20.0, color: Colors.white),
    );
  }
  else if(num==5){
    return const Text(
      '😨', // Replace with desired emoji//fearful,
      style: TextStyle(fontSize: 20.0, color: Colors.white),
    );
  }
  else if(num==6){
    return const Text(
      '😱', // Replace with desired emoji//shocked,
      style: TextStyle(fontSize: 20.0, color: Colors.white),
    );
  }
  else if(num==7){
    return const Text(
      '🤩', // Replace with desired emoji//fascinated
      style: TextStyle(fontSize: 20.0, color: Colors.white),
    );
  }
  else{
   return const Icon(Icons.add_circle, size: 30,color: Colors.black45,);
  }
}
