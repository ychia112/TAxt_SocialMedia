import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ios_proj01/pages/post_page.dart';
import 'package:ios_proj01/widgets/post_viewing.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../providers/metamask_provider.dart';
import '../utils/user_info.dart';
import 'Diarydata.dart';
import 'package:google_fonts/google_fonts.dart';
import 'new_diary.dart';

class InDiaryPage extends StatefulWidget {
  final String diaryId;
  final String anotherOwner;

  const InDiaryPage({
    super.key, 
    required this.diaryId,
    required this.anotherOwner
  });

  @override
  State<InDiaryPage> createState() => _InDiaryPageState();
}

class _InDiaryPageState extends State<InDiaryPage> {
  late Future<UserInfo> anotherOwnerInfo;

  @override
  void initState() {
    anotherOwnerInfo = getAnotherOwnerInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        title: FutureBuilder<UserInfo>(
          future: anotherOwnerInfo,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return Text(
                'Diary with ${snapshot.data!.name}',
                style: GoogleFonts.abrilFatface(
                    textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    )),
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
          }
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserPost(diaryId: widget.diaryId)),
              );
            },
            icon: const Icon(Icons.post_add_rounded),
          ),
        ],
      ),
      body: ListView(
        children: [PostViewingWidget(diaryId: widget.diaryId)]
      )
    );
  }

  Future<UserInfo> getAnotherOwnerInfo() async {
    final url = Uri.parse("${dotenv.env['backend_address']}/api/getUserInfo?address=${widget.anotherOwner}");
    http.Response res = await http.get(url);
    final infoObject = jsonDecode(res.body);
    if (!infoObject.containsKey('name')){
      return UserInfo();
    }
    return UserInfo.fromJson(infoObject);
  }
}
