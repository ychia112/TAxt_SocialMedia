import 'package:flutter/material.dart';
import 'Diarydata.dart';

class DiaryPage extends StatefulWidget {
  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  final List<Diary> _diaries = [
    Diary(
        title: 'Diary1',
        author: 'a',
        coverImage:
        'https://marketplace.canva.com/EAFMUPbPgjs/1/0/1236w/canva-tan-beige-neutral-floral-illustrated-notebook-cover-72hqsit8LD4.jpg'),
    Diary(
        title: 'Diary2',
        author: 'ab',
        coverImage:
        'https://marketplace.canva.com/EAFMUPbPgjs/1/0/1236w/canva-tan-beige-neutral-floral-illustrated-notebook-cover-72hqsit8LD4.jpg'),
    Diary(
        title: 'Diary3',
        author: 'ac',
        coverImage:
        'https://marketplace.canva.com/EAFMUPbPgjs/1/0/1236w/canva-tan-beige-neutral-floral-illustrated-notebook-cover-72hqsit8LD4.jpg'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diary Books'),
        backgroundColor: Colors.white,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
        ),
        itemCount: _diaries.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.(vertical: 12, horizontal: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: Image.network(
                _diaries[index].coverImage,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
