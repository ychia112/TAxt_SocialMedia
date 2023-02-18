import 'dart:async';
import 'package:flutter/material.dart';
import 'post.dart';
import 'chat.dart';

String _nowmood=""; //存目前版面的心情
final List chosen = <String>["0"]; //每則貼文的文字// initial show post 0
var storing = store(); //存每個貼文的心情

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHome();
}

class _UserHome extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    if (storing.isNotEmpty){
      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            // leading:
            flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Colors.black,
                ),
                title: Text('A p p N a m e '),
                centerTitle: true
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => chatScreen()),
                  );
                },
                icon: const Icon(Icons.mark_chat_unread_outlined,size: 30,),
                alignment: Alignment.centerLeft,
              ),
            ],
          ),
          body:
            Column(
                children:[
                  //const MyStatefulWidget(),
                  Expanded(
                    child:
                      SingleChildScrollView(
                        padding: EdgeInsets.all(12),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const MyStatefulWidget(),
                              Container(
                                height: MediaQuery.of(context).size.height-250,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey.shade50,
                                child:
                                ListView.separated(
                                    itemCount: storing.length,
                                    padding: const EdgeInsets.only(top:5.0,bottom:15.0),
                                    separatorBuilder: (BuildContext context,int index)=>
                                    const Divider(height: 16,color: Color(0xFFFFFFFF)),
                                    itemBuilder: (BuildContext context, int index) {
                                      return Container(
                                          alignment: Alignment.center,
                                          // tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(24.0),
                                            color:  Colors.grey.shade300,
                                          ),
                                          child:
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(

                                                children:[
                                                  const Padding(padding: EdgeInsets.only(top:60.0,left: 10)),
                                                  ClipOval(
                                                      child:
                                                      Image.asset('assets/images/2.jpg',width: 50,height: 50,fit: BoxFit.cover,)
                                                  ),
                                                ],
                                              ),
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
                                                          //borderRadius: BorderRadius.circular(24.0),
                                                          color:  Colors.grey.shade200,),
                                                        child:
                                                        Text(
                                                            storing[index], textAlign: TextAlign.center,
                                                            maxLines: 10),
                                                      )
                                                  )

                                                ],
                                              ),
                                              Row(
                                                children: [

                                                  // const Padding(padding: EdgeInsets.only(top:20.0,bottom: 20)),
                                                  PopupMenuButton<String>(
                                                      offset: const Offset(40,40),

                                                      icon:const Icon(Icons.add_circle,size: 30,color: Colors.black54,),
                                                      // icon:const Icon(Icons.import_export_rounded,color: Colors.white,),
                                                      onSelected: (String value) {
                                                        setState(() {
                                                          chosen[index]=value;
                                                          //Color:Colors.red;
                                                        });
                                                      },
                                                      itemBuilder: (BuildContext context) =>
                                                      <PopupMenuEntry<String>>[
                                                        const PopupMenuItem<String>(
                                                          value: "tryone",
                                                          child: Icon(Icons.insert_emoticon,color: Colors.black45),
                                                        ),
                                                        const PopupMenuItem<String>(
                                                          value:"trytwo",
                                                          child: Icon(Icons.emoji_emotions_rounded,color: Colors.black45),
                                                        ),
                                                        const PopupMenuItem<String>(
                                                          value: "trythree",
                                                          child: Icon(Icons.favorite_border_outlined,color: Colors.black45),
                                                        ),
                                                        const PopupMenuItem<String>(
                                                          value: "tryfour",
                                                          child: Icon(Icons.favorite_outlined,color: Colors.black45),
                                                        ),
                                                      ]
                                                  ),
                                                  Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width-124)),
                                                  IconButton(
                                                    icon: const Icon(Icons.account_circle,size: 30,color: Colors.black54,),
                                                    onPressed: (
                                                        ){},
                                                    alignment: Alignment.bottomRight,
                                                  ),

                                                ],
                                              ),
                                            ],
                                          )
                                      );
                                    }
                                ),
                              ),
                            ]
                        )
                    ),
                  )
                ]
            )

      );
    }
    else {
      return Scaffold(
        appBar: AppBar(
          //leading:Icon(Icons.account_tree_outlined),
          flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.black,
              ),
              title: Text('A p p N a m e '),
              centerTitle: true
          ),
          actions: [
            IconButton(
              onPressed: () {
                // _popupMenuButton(context);
              },
              icon: const Icon(Icons.account_circle_outlined,size: 30,),
              alignment: Alignment.centerLeft,
            ),
          ],
        ),
      );
    }

  }
}


List? chose()=> chosen;
//
// ExpansionTile(
// title: Text(''),
// subtitle: Text('Trailing expansion arrow icon'),
// children: <Widget>[
// ListTile(title: Text('This is tile number 1')),
// ],
// ),

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int count=0;
  GlobalKey<_TextWidgetState> textKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SingleChildScrollView(
          child: ExpansionTile(
            title: TextWidget(textKey),
            controlAffinity: ListTileControlAffinity.leading,
            children: <Widget>[
              ListTile(
                  title: Center(
                    child: Row(
                      children: [
                        IconButton(
                            onPressed:() {
                              _nowmood="happy";
                              textKey.currentState?.onPressed();
                            },
                            icon: Icon(Icons.insert_emoticon)),
                        IconButton(
                            onPressed:(){
                              _nowmood="unhappy";
                              textKey.currentState?.onPressed();
                            },
                            icon: Icon(Icons.emoji_emotions_rounded)),
                        IconButton(
                            onPressed:(){
                              _nowmood="happy100";
                              textKey.currentState?.onPressed();
                            },
                            icon: Icon(Icons.favorite_border_outlined)),
                        IconButton(
                            onPressed:(){
                              _nowmood="unhappy1000";
                              textKey.currentState?.onPressed();
                            },
                            icon: Icon(Icons.favorite_outlined)),

                      ],
                    ),
                  ),
                  contentPadding:EdgeInsets.symmetric(horizontal: 12.0),

              ),
            ],
          ),
        )

      ],
    );
  }
}

class TextWidget extends StatefulWidget {
  final Key key;

  const TextWidget(this.key);

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  String text = "filter the mood";
  void onPressed() {
    setState((){
      text = _nowmood;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}

