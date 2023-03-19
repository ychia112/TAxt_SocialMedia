import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ios_proj01/pages/in_diary.dart';
import 'package:ios_proj01/widgets/post_viewing.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../providers/metamask_provider.dart';
import 'Diarydata.dart';
import 'package:google_fonts/google_fonts.dart';
import 'new_diary.dart';

class DiaryPage extends StatefulWidget {
  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  late Future<List<dynamic>> _diaries;
  String? diaryId;

  Future<List<dynamic>> getUserDiaries() async {
    final url = Uri.parse("${dotenv.env['backend_address']}/api/diary/get-all-diaries-owned-by?owner=${context.read<MetaMask>().getAddress()}");
    http.Response res = await http.get(url);
    final ret = jsonDecode(res.body);
    return ret;
  }

  @override
  void initState() {
    _diaries = getUserDiaries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        title: Text(
          'Diaries',
          style: GoogleFonts.abrilFatface(
              textStyle: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              )),
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewDiary()),
              );
            },
            icon: const Icon(Icons.bookmark_add_rounded),
          ),
        ],
      ),
      body: diaryList(),
    );
  }

  Widget diaryList() => FutureBuilder<List<dynamic>>(
    future: _diaries,
    builder: (context, snapshot) {
      if(snapshot.hasData){
        return Theme(
          data:ThemeData(
            canvasColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child:Column(
            children: [
              for (final tile in snapshot.data!)
                GestureDetector(
                  key: ValueKey(tile['owner1'] == context.read<MetaMask>().getAddress()? tile['owner2']: tile['owner1']),
                  onTap: () {
                    //insert page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InDiaryPage(
                        diaryId: tile['id'], 
                        anotherOwner: tile['owner1'] == context.read<MetaMask>().getAddress()? tile['owner2']: tile['owner1'],
                      )),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                    child: Container(
                      height: 96,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        color:  Colors.grey.shade300,
                      ),
                      child: ListTile(
                        title: Text(tile['owner1'] == context.read<MetaMask>().getAddress()? tile['owner2']: tile['owner1']),
                      ),
                    ),
                  ),
                ),
            ],
          ),
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
  );
}
