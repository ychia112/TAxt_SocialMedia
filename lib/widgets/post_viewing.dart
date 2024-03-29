import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:ios_proj01/pages/profile.dart';
import 'package:ios_proj01/providers/metamask_provider.dart';
import 'package:ios_proj01/utils/post.dart';
import 'package:ios_proj01/utils/user_info.dart';
import 'package:ios_proj01/widgets/additionaltext.dart';
import 'package:provider/provider.dart';
import '../utils/mood.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pages/post_page.dart';

class PostViewingWidget extends StatefulWidget{
  final String? address;
  final String? diaryId;

  const PostViewingWidget({
    super.key,
    this.address,
    this.diaryId
  });

  @override
  State<PostViewingWidget> createState() => _PostViewingWidgetState();
}

class _PostViewingWidgetState extends State<PostViewingWidget> {
  final GlobalKey expansionTileKey = GlobalKey();
  late Future<List<Post>> _posts;
  late Future<List<Post>> filteredPosts;
  Mood filterMood = Mood.none;

  Future<List<Post>> getAllPosts() async {
    http.Response res = await http.get(Uri.parse("${dotenv.env['backend_address']}/api/get-all-posts"));
    final rawPosts = jsonDecode(res.body);
    List<Post> ret = [];
    for(dynamic post in rawPosts){
      ret.add(Post(
        userInfo: post.containsKey('userInfo')? UserInfo.fromJson(post['userInfo']): UserInfo(),
        context: PostContext.fromJson(post['context'])
      ));
    }
    return ret;
  }

  Future<List<Post>> filterPosts() async {
    if(filterMood == Mood.none){
      return _posts;
    }
    List<Post> ret = [];
    for(Post post in await _posts){
      if(post.context.mood == filterMood){
        ret.add(post);
      }
    }
    return ret;
  }

  Future<List<Post>> getUserPosts() async {
    final url = Uri.parse("${dotenv.env['backend_address']}/api/get-all-posts-owned-by?owner=${widget.address}");
    http.Response res = await http.get(url);
    final rawPosts = jsonDecode(res.body);
    List<Post> ret = [];
    for(dynamic post in rawPosts){
      ret.add(Post(
        userInfo: post.containsKey('userInfo')? UserInfo.fromJson(post['userInfo']): UserInfo(),
        context: PostContext.fromJson(post['context'])
      ));
    }
    return ret;
  }

  Future<List<Post>> getDiaryPages() async {
    final url = Uri.parse("${dotenv.env['backend_address']}/api/diary/get-all-pages-of-diary?diaryId=${widget.diaryId}");
    http.Response res = await http.get(url);
    final rawPosts = jsonDecode(res.body);
    List<Post> ret = [];
    for(dynamic post in rawPosts){
      ret.add(Post(
        userInfo: post.containsKey('userInfo')? UserInfo.fromJson(post['userInfo']): UserInfo(),
        context: PostContext.fromJson(post['context'])
      ));
    }
    return ret;
  }

  @override
  void initState() {
    if(widget.address != null){
      _posts = getUserPosts();
    }
    else if(widget.diaryId != null){
      _posts = getDiaryPages();
    }
    else{
      _posts = getAllPosts();
    }
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
                  singlePost(snapshot.data![i]),
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
            title: const Text("Filter"),
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
        shape: const CircleBorder(),
        child: Text(
          moodEmoji[mood.index], // Replace with desired emoji//happy
          style: const TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }

  Widget singlePost(Post post){
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
                child: Material(
                  color: Colors.transparent,
                  child:Ink.image(
                    image: NetworkImage(post.userInfo.getImagePath()),
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                    child: InkWell(onTap: (){
                      if(widget.address != post.context.author && context.read<MetaMask>().getAddress() != post.context.author){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=> UserProfile(
                            address: post.context.author, 
                            viewByOwner: false,
                            isSearchPage: false)
                          )
                        ).then((value) {
                          setState(() {});
                        });
                      }
                    }),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                post.userInfo.name, // Replace with desired emoji//happy
                style: GoogleFonts.merriweather(fontWeight: FontWeight.bold, fontSize: 14),
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
                  child: _textPaint([TextSpan(text: post.context.text)]).didExceedMaxLines ? RichText(
                      text: TextSpan(
                          text: post.context.text.substring(0, _fontNum(post.context.text)),
                          style: const TextStyle(color: Colors.black,fontSize:14),
                          recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            num.clear();
                            num.add(post.userInfo.name);
                            num.add(post.userInfo.getImagePath());
                            num.add(post.context.text);
                            num.add(post.context.mood.index);
                            num.add(post.context.datetime);
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
                                  num.add(post.userInfo.name);
                                  num.add(post.userInfo.getImagePath());
                                  num.add(post.context.text);
                                  num.add(post.context.mood.index);
                                  num.add(post.context.datetime);
                                  Navigator.push(
                                    context,
                                  MaterialPageRoute(builder: (context) => Extratext()),
                                  );
                              } )
                          ]
                        ),
                        textAlign: TextAlign.start,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 25,
                      ):Container( //未超出指定行数的话全部显示
                          child: Text(
                          post.context.text,
                            style: const TextStyle(fontSize:14),
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
                    moodEmoji[post.context.mood.index], // Replace with desired emoji//happy
                    style: const TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                )
              ),
              const Spacer(),
              if(post.context.datetime != "")
                Text(displayDateTime(post.context.datetime!)),
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
        maxLines: 25,
        text: TextSpan(
            children: children
        ),
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: MediaQuery.of(context).size.width - 40);
  }
  //count the most num of word showing
  int _fontNum(String postContext){
    int num = 0;
    int skip = 7;
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
  else if(duration.inMinutes!=0){
    output += '${duration.inMinutes}';
    output += (duration.inMinutes <= 1? ' min ago': ' mins ago');
  }
  else {
    output+=('few seconds ago');
  }
  return output;
}
