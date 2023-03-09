import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:ios_proj01/widgets/additionaltext.dart';
import '../utils/mood.dart';

List num=[];

class PostViewingWidget extends StatefulWidget{
  final String? address;

  const PostViewingWidget({
    super.key,
    this.address,
  });

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

  Future<List<dynamic>> getUserPosts() async {
    final url = Uri.parse("${dotenv.env['backend_address']}/api/get-all-posts-owned-by?owner=${widget.address}");
    http.Response res = await http.get(url);
    return jsonDecode(res.body);
  }

  @override
  void initState() {
    _posts = (widget.address == null ? getAllPosts(): getUserPosts());
    filteredPosts = filterPosts();
    super.initState();
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
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  constraints: BoxConstraints(
                    minHeight: 200,
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  decoration: BoxDecoration(
                    color:  Colors.grey.shade200,
                  ),
                  child: _textPaint([TextSpan(text: postContext)]).didExceedMaxLines ? RichText(
                      text: TextSpan(
                          //text:postContext,
                          text: postContext.substring(0, _fontNum(postContext)),
                          style: const TextStyle(color: Colors.black),
                          recognizer: TapGestureRecognizer()
                          ..onTap = () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Extratext()),
                          );},
                          children: [
                            TextSpan(
                              text: "...read more   ",
                              style: const TextStyle(color: Colors.black26),
                              recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                  num.clear();
                                  num.add(author);
                                  num.add(postContext);
                                  num.add(moodIndex);
                                  num.add(dateTimeString);
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Extratext()),
                                  );
                              } )
                          ]
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                      ):Container( //未超出指定行数的话全部显示
                          child: Text(
                          postContext,
                        ),
                )
                )
              )
            ]),
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
      ),
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
  TextPainter _textPaint(List<InlineSpan> children) {
    return TextPainter(
        maxLines: 10,
        text: TextSpan(
            children: children
        ),
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: MediaQuery.of(context).size.width - 40);
  }
  int _fontNum(String postContext){ //计算最多可容纳正常字的数目，可优化
    int num = 0;
    int skip = 1;
    String additionText="";
    while(true){
      bool isExceed = postContext.length < num + skip ||  _textPaint([TextSpan(text: "${postContext.substring(0, num + skip)}...", ),
        TextSpan(text: additionText)]).didExceedMaxLines;
      if(!isExceed) {
        num = num + skip;
        skip *= 2;
        continue;
      }
      if(isExceed && skip == 1){
        return num;
      }
      skip = skip ~/ 2;
    }
  }

}
String displayDateTime(String dateTimeString){
  DateTime postDateTime = DateTime.parse(dateTimeString);
  Duration duration = DateTime.now().difference(postDateTime);
  if(duration.inDays >= 7){
    return postDateTime.toLocal().toString().substring(0, 16);
  }

  String output = "";

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

  return output;
}

List postnum (){
  return num;
}