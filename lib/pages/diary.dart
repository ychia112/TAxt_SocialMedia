import 'package:flutter/material.dart';
import 'Diarydata.dart';
import 'package:google_fonts/google_fonts.dart';
import 'new_diary.dart';

class DiaryPage extends StatefulWidget {
  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  final List diarybooks = [
    'A',
    'B',
    'C',
    'D',
  ];

  void updateTiles(int oldIndex, int newIndex){
    setState(() {
      if(oldIndex < newIndex){
        newIndex -= 1;
      }

      final String tile = diarybooks.removeAt(oldIndex);
      diarybooks.insert(newIndex, tile);
    });
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
              textStyle: TextStyle(
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
            icon: Icon(Icons.bookmark_add_rounded),
          ),
        ],
      ),
      body: Theme(
        data:ThemeData(
          canvasColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child:ReorderableListView(
        padding: const EdgeInsets.all(6),
        children: [
          for (final tile in diarybooks)
              GestureDetector(
                key: ValueKey(tile),
                onTap: () {
                  //insert page
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
                      title: Text(tile.toString()),
                    ),
                  ),
                ),
              ),

        ],
        onReorder: (oldIndex, newIndex){
          updateTiles(oldIndex, newIndex);
        },
      ),
      ),
    );
  }
}
