import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../utils/mood.dart';

class PostViewingWidget extends StatefulWidget{
  const PostViewingWidget({super.key});

  @override
  State<PostViewingWidget> createState() => _PostViewingWidgetState();
}

class _PostViewingWidgetState extends State<PostViewingWidget> {
  final GlobalKey expansionTileKey = GlobalKey();
  late Future<List<dynamic>> _posts;
  late Future<List<dynamic>> filteredPosts;
  
  Mood filterMood = Mood.none;

  Future<List<dynamic>> getAllPosts() async {
    http.Response res = await http.get(Uri.parse("${dotenv.env['backend_address']}/api/get-all-posts"));
    return jsonDecode(res.body);
  }
  
  Future<List<dynamic>> filterPosts() async {
    List<dynamic> filteredPosts = [];
    filteredPosts.clear();

    if(filterMood == Mood.none){
      filteredPosts = await _posts;
      return filteredPosts;
    }
    
    for(dynamic post in await _posts){
      if(post['mood'] == filterMood.index){
        filteredPosts.add(post);
      }
    }

    return filteredPosts;
  }

  @override
  void initState() {
    _posts = getAllPosts();
    filteredPosts = filterPosts();

    super.initState();
  }

  String displayDateTime(String dateTimeString){
    DateTime postDateTime = DateTime.parse(dateTimeString);
    Duration duration = DateTime.now().difference(postDateTime);
    String output = '${postDateTime.toLocal().toString().substring(0, 16)} (';
    
    if(duration.inDays != 0){
      output += '${duration.inDays}';
      output += (duration.inDays == 1? ' day ago': ' days ago');
    }
    else if(duration.inHours != 0){
      output += '${duration.inHours}';
      output += (duration.inHours == 1? ' hour ago': ' hours ago');
    }
    else {
      output += '${duration.inMinutes}';
      output += (duration.inMinutes <= 1? ' min ago': ' mins ago');
    }

    output += ')';

    return output;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: filteredPosts,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Column(
            children: [
              filterBlock(),
              for(int i = snapshot.data!.length - 1; i >= 0; i--)
                ...[
                  singlePost(
                    snapshot.data![i]['author'],
                    snapshot.data![i]['context'],
                    snapshot.data![i]['mood'],
                    snapshot.data![i].containsKey('datetime')? snapshot.data![i]['datetime'] : "",
                  ),
                  const SizedBox(height: 20,),
                ]
            ]
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
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
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
    );
  }

  Widget filterBlock(){
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
                  for(var i = 0; i < Mood.values.length; i++)
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
          setState(() {
            filterMood = mood;
            filteredPosts = filterPosts();
          });
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

  Widget singlePost(String author, String postContext, int moodIndex, String dateTimeString){
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color:  Colors.grey.shade300,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children:[
              const Padding(padding: EdgeInsets.only(top:60.0,left: 10)),
              ClipOval(
                child: Image.asset('assets/images/2.jpg', width: 50, height: 50, fit: BoxFit.cover,)
              ),
              const SizedBox(width: 8),
              Text(
                author, // Replace with desired emoji//happy
                style: const TextStyle(fontSize: 11.0, color: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  constraints: BoxConstraints(
                    minHeight: 200,
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  decoration: BoxDecoration(
                    color:  Colors.grey.shade200,
                  ),
                  child: Text(
                    postContext, 
                    textAlign: TextAlign.center
                  ),
                )
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
                height: 40,
                //color: Colors.black26,
                child: RawMaterialButton(
                  onPressed: () {},
                  // fillColor: Colors.transparent,
                  highlightColor:Colors.transparent,
                  splashColor:Colors.transparent,
                  hoverColor:Colors.transparent,
                  shape: const CircleBorder(),
                  child: Text(
                    moodEmoji[moodIndex], // Replace with desired emoji//happy
                    style: const TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                )
              ),
              const Spacer(),
              if(dateTimeString != "")
                Text(displayDateTime(dateTimeString)),
              const SizedBox(width: 10,)
            ],
          ),
        ],
      )
    );
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
}