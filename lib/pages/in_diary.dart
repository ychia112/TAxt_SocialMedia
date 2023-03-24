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
  final String diaryName;

  const InDiaryPage(
      {super.key, required this.diaryId, required this.diaryName});

  @override
  State<InDiaryPage> createState() => _InDiaryPageState();
}

class _InDiaryPageState extends State<InDiaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          backgroundColor: Colors.transparent,
          title: Text(
            widget.diaryName,
            style: GoogleFonts.abrilFatface(
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserPost(diaryId: widget.diaryId)),
                );
              },
              icon: const Icon(Icons.post_add_rounded),
            ),
          ],
        ),
        body: ListView(children: [PostViewingWidget(diaryId: widget.diaryId)]));
  }
}
