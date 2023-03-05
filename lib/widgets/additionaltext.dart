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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.transparent,),
        body: SingleChildScrollView(
            child:
                Row(
                  children: [
                    Container(
                      //alignment: Alignment.center,
                      constraints: BoxConstraints(
                        minHeight: 400,
                        //maxHeight: 400,
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        color:  Colors.grey.shade300,
                      ),
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
                                          maxWidth: MediaQuery.of(context).size.width,
                                        ),
                                        decoration: BoxDecoration(
                                          color:  Colors.grey.shade200,
                                        ),
                                        child: Text(
                                          //"postContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContext",
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
                              //const SizedBox(width: 10,)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )

    ));
  }
}