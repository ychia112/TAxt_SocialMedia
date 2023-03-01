import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'post.dart';
import '../utils/mood.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

Mood filter_mood = Mood.none; //存目前版面的心情(int)

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);
  @override
  State<UserHome> createState() => _UserHome();
}

class _UserHome extends State<UserHome> {
  late final Future<List<dynamic>> _posts = getAllPosts();
  List<dynamic> filtered_posts = [];

  Future<List<dynamic>> getAllPosts() async {
    http.Response res = await http.get(Uri.parse("${dotenv.env['backend_address']}/api/get-all-posts"));
    return jsonDecode(res.body);
  }

  String DisplayDateTime(String dateTimeString){
    DateTime postDateTime = DateTime.parse(dateTimeString);
    Duration duration = DateTime.now().difference(postDateTime);
    String output = postDateTime.toLocal().toString().substring(0, 16) + ' (';
    if(duration.inDays != 0){
      output += '${duration.inDays}';
      output += (duration.inDays == 1? ' day ago': 'days ago');
    }
    else if(duration.inHours != 0){
      output += '${duration.inHours}';
      output += (duration.inHours == 1? ' hour ago': 'hours ago');
    }
    else {
      output += '${duration.inMinutes}';
      output += (duration.inMinutes <= 1? ' min ago': 'mins ago');
    }
    output += ')';
    return output;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        // leading:
            title: Text(
                dotenv.env['app_name']?? "load failed",
                style: GoogleFonts.abrilFatface(
                    textStyle: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )),
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
            color: Colors.black,
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
                                  index = snapshot.data!.length - 1 - index;
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
                                            const SizedBox(width: 8),
                                            Text(
                                              snapshot.data![index]['author'], // Replace with desired emoji//happy
                                              style: const TextStyle(fontSize: 11.0, color: Colors.black),
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
                                              child: RawMaterialButton(
                                                onPressed: () {},
                                                fillColor: Colors.white,
                                                shape: const CircleBorder(),
                                                child: Text(
                                                  moodEmoji[snapshot.data![index]['mood']], // Replace with desired emoji//happy
                                                  style: const TextStyle(fontSize: 20.0, color: Colors.white),
                                                ),
                                              )
                                            ),
                                            const Spacer(),
                                            if(snapshot.data![index].containsKey('datetime'))
                                              Text(DisplayDateTime(snapshot.data![index]['datetime'])),
                                            const SizedBox(width: 10,)
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
            title: const Text("filter the mood"),
            controlAffinity: ListTileControlAffinity.leading,
            children: [
              Row(
                children:[
                  for(var i = 1; i < Mood.values.length; i++)
                    emojiSizedBox(Mood.values[i])
           ] ),]
          ),
      ],
    );
  }

  Widget emojiSizedBox(Mood mood){
    return SizedBox(
      height: 40,
      width: 40,
      child: RawMaterialButton(
        onPressed: () {
          filter_mood = mood;
        },
        //fillColor: Colors.white,
        shape: const CircleBorder(),
        child: Text(
          moodEmoji[mood.index], // Replace with desired emoji//happy
          style: const TextStyle(fontSize: 20.0),
        ),
      ),
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