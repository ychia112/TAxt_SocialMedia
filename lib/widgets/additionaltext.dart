import 'dart:core';
import 'package:flutter/material.dart';
import '../utils/mood.dart';
import 'post_viewing.dart';

class Extratext extends StatefulWidget{
  //Extratext({ required this.author, required this.postContext, required this.moodIndex, required this.dateTimeString,super.key,});

  // String author;
  // String postContext;
  // int moodIndex;
  // String dateTimeString;
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         elevation: 0,
  //         centerTitle: false,
  //         iconTheme: const IconThemeData(
  //           color: Colors.black, //change your color here
  //         ),
  //         backgroundColor: Colors.transparent,),
  //       body: Container(
  //         alignment: Alignment.center,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(24.0),
  //           color:  Colors.grey.shade300,
  //         ),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Row(
  //               children:[
  //                 const Padding(padding: EdgeInsets.only(top:60.0,left: 10)),
  //                 ClipOval(
  //                     child: Image.asset('assets/images/2.jpg', width: 50, height: 50, fit: BoxFit.cover,)
  //                 ),
  //                 const SizedBox(width: 8),
  //                 Text(
  //                   author, // Replace with desired emoji//happy
  //                   style: const TextStyle(fontSize: 11.0, color: Colors.black),
  //                 ),
  //               ],
  //             ),
  //             Row(
  //                 children: [
  //                   Center(
  //                       child: Container(
  //                           padding: const EdgeInsets.all(16),
  //                           alignment: Alignment.center,
  //                           constraints: BoxConstraints(
  //                             minHeight: 200,
  //                             maxWidth: MediaQuery.of(context).size.width,
  //                           ),
  //                           decoration: BoxDecoration(
  //                             color:  Colors.grey.shade200,
  //                           ),
  //                           child: Text(
  //                             postContext,
  //                             style: const TextStyle(color: Colors.black),
  //                           )
  //
  //
  //                       )
  //                   )
  //                 ]),
  //             Row(
  //               children: [
  //                 SizedBox(
  //                     width: 50,
  //                     height: 40,
  //                     //color: Colors.black26,
  //                     child: RawMaterialButton(
  //                       onPressed: () {},
  //                       // fillColor: Colors.transparent,
  //                       highlightColor:Colors.transparent,
  //                       splashColor:Colors.transparent,
  //                       hoverColor:Colors.transparent,
  //                       shape: const CircleBorder(),
  //                       child: Text(
  //                         moodEmoji[moodIndex], // Replace with desired emoji//happy
  //                         style: const TextStyle(fontSize: 20.0, color: Colors.white),
  //                       ),
  //                     )
  //                 ),
  //                 const Spacer(),
  //                 if(dateTimeString != "")
  //                   Text(displayDateTime(dateTimeString)),
  //                 const SizedBox(width: 10,)
  //               ],
  //             ),
  //           ],
  //         ),
  //       )
  //   );
  // }
  @override
  _Extratext createState() => _Extratext();
}
class _Extratext extends State<Extratext> {
  // String author;
  // String postContext;
  int moodIndex=0;
  String dateTimeString="";
  //_Extratext({required this.author, required this.postContext, required this.moodIndex, required this.dateTimeString});
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
                    "author", // Replace with desired emoji//happy
                    style: const TextStyle(fontSize: 11.0, color: Colors.black),
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
                              "postContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContextpostContext",
                              style: const TextStyle(color: Colors.black),
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
                          moodEmoji[moodIndex], // Replace with desired emoji//happy
                          style: const TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      )
                  ),
                  const Spacer(),
                  if(dateTimeString != "")
                    Text(displayDateTime(dateTimeString)),
                  const SizedBox(width: 10,)
                ],
              ),
            ],
          ),
        )
    ));
  }
}