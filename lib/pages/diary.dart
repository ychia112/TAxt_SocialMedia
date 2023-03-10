import 'package:flutter/material.dart';
import 'Diarydata.dart';
import 'package:google_fonts/google_fonts.dart';
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
        automaticallyImplyLeading: false,
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
            onPressed: (){},
            icon: Icon(Icons.bookmark_add_rounded),
          ),
        ],
      ),
      body: ReorderableListView(
        padding: const EdgeInsets.all(6),
        children: [
          for (final tile in diarybooks)
            Padding(
              key: ValueKey(tile),
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
        ],
        onReorder: (oldIndex, newIndex){
          updateTiles(oldIndex, newIndex);
        },
      ),
    );
  }
}
