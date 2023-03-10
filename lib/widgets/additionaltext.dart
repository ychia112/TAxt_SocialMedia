import 'dart:core';
import 'package:flutter/material.dart';
import '../utils/mood.dart';
import 'post_viewing.dart';
import 'package:ios_proj01/homepage.dart';

class Extratext extends StatefulWidget{
  @override
  var num=postnum();
  _Extratext createState() => _Extratext();
}
class _Extratext extends State<Extratext> {
  //int moodIndex=0;
  //String dateTimeString="";
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
          AppBar(
              toolbarHeight:40,
            elevation: 0,
            centerTitle: false,
            iconTheme: const IconThemeData(
              color: Colors.white, //change your color here
            ),
            backgroundColor: Colors.black26),
        body:SingleChildScrollView(
            child:Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 3,right: 3),),
                    const Padding(padding: EdgeInsets.only(bottom: 5),),
                    Container(
                      //alignment: Alignment.center,
                      constraints: BoxConstraints(
                        minHeight: 400,
                        //maxHeight: 400,
                        maxWidth: MediaQuery.of(context).size.width-10,
                      ),

                      // decoration: BoxDecoration(
                      //   //borderRadius: BorderRadius.circular(24.0),
                      //   color:  Colors.grey.shade300,
                      // ),
                      // decoration: const BoxDecoration(
                      //   border: Border(
                      //     bottom: BorderSide(width: 16.0, color: Colors.black54),)
                      // ),

                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children:[
                              const Padding(padding: EdgeInsets.only(top:60.0,left: 10)),
                              ClipOval(
                                  child: Image.asset('assets/images/2.jpg', width: 50, height: 50, fit: BoxFit.cover,)
                              ),
                              const SizedBox(width: 8),
                              Text(
                                num[0], // Replace with desired emoji//happy
                                style: TextStyle(fontSize: 11.0, color: Colors.black),
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
                                          maxWidth: MediaQuery.of(context).size.width-10,
                                        ),
                                        decoration: BoxDecoration(
                                          color:  Colors.grey.shade200,
                                          border: const Border(
                                              top: BorderSide(width: 4.0, color: Colors.black12),
                                            bottom: BorderSide(width: 4.0, color: Colors.black12),),
                                        ),
                                        child: Text(
                                          num[1],
                                          style: TextStyle(color: Colors.black),
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
                                      moodEmoji[num[2]], // Replace with desired emoji//happy
                                      style: const TextStyle(fontSize: 20.0, color: Colors.white),
                                    ),
                                  )
                              ),
                              const Spacer(),
                              if(num[3] != "")
                                Text(displayDateTime(num[3])),

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