import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/mood.dart';
import 'post_viewing.dart';
import '../pages/post_page.dart';

class Extratext extends StatefulWidget {
  var num = postnum(); //retrieve the post that is being press for read more
  @override
  _Extratext createState() => _Extratext();
}
class _Extratext extends State<Extratext> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
      elevation: 0,
      centerTitle: false,
      iconTheme: const IconThemeData(
        color: Colors.black, //change your color here
      ),
      backgroundColor: Colors.transparent,),
      body: SingleChildScrollView(
          child: Row(
            children: [
              Container(
            alignment: Alignment.center,
                constraints: BoxConstraints(
                  minHeight: 400,
                  //maxHeight: 400,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color:  Colors.grey.shade300,
            ),

            child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children:[
                      const Padding(padding: EdgeInsets.only(top:60.0,left: 10)),
                      ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child:Image.network(num[1],
                              width: 50, height: 50, fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                          num[0],
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
                                child: Text(num[2],style: const TextStyle(color: Colors.black),)
                            )
                        )
                      ]),
                  Row(
                    children: [
                      SizedBox(
                          width: 50,
                          height: 40,
                          child: RawMaterialButton(
                            onPressed: () {},

                            highlightColor:Colors.transparent,
                            splashColor:Colors.transparent,
                            hoverColor:Colors.transparent,
                            shape: const CircleBorder(),
                            child: Text(
                              moodEmoji[num[3]],
                              style: const TextStyle(fontSize: 20.0, color: Colors.white),
                            ),
                          )
                      ),
                      const Spacer(),
                      if (num[4] != "")
                          Text(displayDateTime(num[4])),
                      const SizedBox(width: 10,)
                    ],
                  ),
                ],
              )
            ),
          ],
      )),
    );
  }
}
