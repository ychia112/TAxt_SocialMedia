import'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewDiary extends StatefulWidget {
  @override
  State<NewDiary> createState() => _NewDiaryState();
}

class _NewDiaryState extends State<NewDiary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:Text(
          'New Diary',
          style: GoogleFonts.abrilFatface(
              textStyle: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              )
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children:[
          SizedBox(height: 12,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'To :',
              style: GoogleFonts.abrilFatface(
                  textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}
