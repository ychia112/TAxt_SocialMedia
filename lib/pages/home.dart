import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'post.dart';
import '../utils/mood.dart';

String _nowmood=""; //存目前版面的心情(string)
int _nowmoodvalue=-1; //存目前版面的心情(int)
final List chosen = <int>[-1,-1,-1,-1,-1]; //存每個貼文的心情//先五篇//-1為blank

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);
  @override
  State<UserHome> createState() => _UserHome();
}

class _UserHome extends State<UserHome> {
  late final Future<List<dynamic>> _posts = getAllPosts();
  Future<List<dynamic>> getAllPosts() async {
    http.Response res = await http.get(Uri.parse("${dotenv.env['backend_address']}/api/get-all-posts"));
    return jsonDecode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        // leading:
        flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: Colors.black,
            ),
            title: Text(dotenv.env['app_name']?? "load failed"),
            centerTitle: true
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserPost()),
              );
            },
            icon: const Icon(Icons.post_add_rounded,size: 30,),
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
                FutureBuilder<List<dynamic>>(
                  future: _posts,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(12),
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
                                itemCount: snapshot.data!.length,
                                padding: const EdgeInsets.only(top:5.0,bottom:15.0),
                                separatorBuilder: (BuildContext context,int index)=>
                                const Divider(height: 16,color: Color(0xFFFFFFFF)),
                                itemBuilder: (BuildContext context, int index) {
                                  if(chosen.length < snapshot.data!.length) {
                                    chosen.add(-1);
                                  }
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
                                                    snapshot.data![index]['context'], textAlign: TextAlign.center,
                                                    maxLines: 10),
                                              )
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 40,
                                              height: 40,
                                              //color: Colors.black26,
                                              child: updateicon(chosen[index]),
                                            )

                                            //Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width-124)),
                                            // IconButton(
                                            //   icon: const Icon(Icons.account_circle,size: 30,color: Colors.black54,),
                                            //   onPressed: (){
                                            //   },
                                            //   alignment: Alignment.bottomRight,
                                            // ),
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
                      );
                    }
                    else{
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text('Awaiting result...'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                )
            )
          ]
        )
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  // int count=0;
  final GlobalKey expansionTileKey = GlobalKey();
  GlobalKey<_TextWidgetState> textKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ExpansionTile(
          key: expansionTileKey,
          onExpansionChanged: (value) {
            if (value) {
              _scrollToSelectedContent(expansionTileKey: expansionTileKey);
            }
          },
            title: TextWidget(textKey),
            controlAffinity: ListTileControlAffinity.leading,
            children: [
              Row(
                children:[
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: RawMaterialButton(
                      onPressed: () {
                        _nowmood = Mood.happy.name;
                        _nowmoodvalue=Mood.happy.index;
                        textKey.currentState?.onPressed();
                      },
                      //fillColor: Colors.white,
                      shape: const CircleBorder(),
                      child: const Text(
                        '😄', // Replace with desired emoji//happy
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: RawMaterialButton(
                      onPressed: () {
                        _nowmood = Mood.angry.name;
                        _nowmoodvalue = Mood.angry.index;
                        textKey.currentState?.onPressed();
                      },
                      //fillColor: Colors.white,
                      shape: const CircleBorder(),
                      child: const Text(
                        '😡', // Replace with desired emoji//angry
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: RawMaterialButton(
                      onPressed: () {
                        _nowmood = Mood.disappointed.name;
                        _nowmoodvalue==Mood.disappointed.index;
                        textKey.currentState?.onPressed();
                      },
                      //fillColor: Colors.white,
                      shape: const CircleBorder(),
                      child: const Text(
                        '😞', // Replace with desired emoji//disappointed
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: RawMaterialButton(
                      onPressed: () {
                        _nowmood = Mood.peaceful.name;
                        _nowmoodvalue=Mood.peaceful.index;
                        textKey.currentState?.onPressed();
                      },
                      //fillColor: Colors.white,
                      shape: const CircleBorder(),
                      child: const Text(
                        '😌', // Replace with desired emoji//peaceful
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: RawMaterialButton(
                      onPressed: () {
                        _nowmood = Mood.disgusted.name;
                        _nowmoodvalue=Mood.disgusted.index;
                        textKey.currentState?.onPressed();
                      },
                      //fillColor: Colors.white,
                      shape: const CircleBorder(),
                      child: const Text(
                        '🤢', // Replace with desired emoji//disgusted
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: RawMaterialButton(
                      onPressed: () {
                        _nowmood = Mood.fearful.name;
                        _nowmoodvalue= Mood.fearful.index;
                        textKey.currentState?.onPressed();
                      },
                      //fillColor: Colors.white,
                      shape: const CircleBorder(),
                      child: const Text(
                        '😨', // Replace with desired emoji//fearful
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: RawMaterialButton(
                      onPressed: () {
                        _nowmood = Mood.shocked.name;
                        _nowmoodvalue=Mood.shocked.index;
                        textKey.currentState?.onPressed();
                      },
                      //fillColor: Colors.white,
                      shape: const CircleBorder(),
                      child: const Text(
                        '😱', // Replace with desired emoji//shocked
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: RawMaterialButton(
                      onPressed: () {
                        _nowmood = Mood.fascinated.name;
                        _nowmoodvalue=Mood.fascinated.index;
                        textKey.currentState?.onPressed();
                      },
                      //fillColor: Colors.white,
                      shape: const CircleBorder(),
                      child: const Text(
                        '🤩', // Replace with desired emoji//fascinated
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                //contentPadding:const EdgeInsets.symmetric(horizontal: 12.0),
           ] ),]
          ),
      ],
    );
  }
}
void _scrollToSelectedContent({required GlobalKey expansionTileKey}) {
  final keyContext = expansionTileKey.currentContext;
  if (keyContext != null) {
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      Scrollable.ensureVisible(keyContext,
          duration: const Duration(milliseconds: 200));
    });
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

List chose()=> chosen;

