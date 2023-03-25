import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/mood.dart';
import 'post_viewing.dart';
import '../pages/post_page.dart';

class Extratext extends StatefulWidget {
  var num = postnum(); //retrieve the post num that is being press for read more
  @override
  _Extratext createState() => _Extratext();
}

class _Extratext extends State<Extratext> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 40,
          elevation: 0,
          centerTitle: false,
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Colors.black26),
      body: SingleChildScrollView(
          child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 3, right: 3),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 5),
          ),
          Container(
            constraints: BoxConstraints(
              minHeight: 400,
              //maxHeight: 400,
              maxWidth: MediaQuery.of(context).size.width - 10,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(top: 60.0, left: 10)),
                    ClipOval(
                      child: Image.network(num[1],
                          width: 50, height: 50, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      num[0],
                      style: GoogleFonts.merriweather(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ), // Replace with desired emoji
                  ],
                ),
                Row(children: [
                  Center(
                      child: Container(
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                          constraints: BoxConstraints(
                            minHeight: 200,
                            maxWidth: MediaQuery.of(context).size.width - 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            border: const Border(
                              top:
                                  BorderSide(width: 4.0, color: Colors.black12),
                              bottom:
                                  BorderSide(width: 4.0, color: Colors.black12),
                            ),
                          ),
                          child: Text(
                            num[2],
                            style: const TextStyle(color: Colors.black),
                          )))
                ]),
                Row(
                  children: [
                    SizedBox(
                        width: 50,
                        height: 40,
                        child: RawMaterialButton(
                          onPressed: () {},
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          shape: const CircleBorder(),
                          child: Text(
                            moodEmoji[
                                num[3]], // Replace with desired emoji//happy
                            style: const TextStyle(
                                fontSize: 20.0, color: Colors.white),
                          ),
                        )),
                    const Spacer(),
                    if (num[4] != "") Text(displayDateTime(num[4])),
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
