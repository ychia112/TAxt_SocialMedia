import 'dart:math';

import 'package:flutter/material.dart';
import 'post.dart';

var storing = store();
enum SampleItem { itemOne, itemTwo, itemThree }

String chosen="0";

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHome();
}

class _UserHome extends State<UserHome> {
  @override
  Widget build(BuildContext context) {

    if (storing.isNotEmpty){
      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: PopupMenuExample(),
            flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Colors.black,
                ),
                title: Text('A p p N a m e '),
                centerTitle: true
            ),
            actions: [
              IconButton(
                onPressed: () {
                },
                icon: const Icon(Icons.mark_chat_unread_outlined,size: 30,),
                alignment: Alignment.centerLeft,
              ),
            ],
          ),
          body:
          Padding(
            padding: const EdgeInsets.only(right :12, left: 12),
            child:
            SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height-150,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey.shade50,
                        child:
                        ListView.separated(
                            itemCount: storing.length,
                            padding: const EdgeInsets.only(top:15.0,bottom:15.0),
                            separatorBuilder: (BuildContext context,int index)=>
                            const Divider(height: 16,color: Color(0xFFFFFFFF)),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  alignment: Alignment.center,
                                  // tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
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
                                              child:
                                              Image.asset('assets/images/2.jpg',width: 50,height: 50,fit: BoxFit.cover,)
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Center(
                                              child: Container(
                                                alignment: Alignment.center,
                                                constraints: const BoxConstraints(
                                                    maxWidth: 515, maxHeight: 250, minWidth: 515, minHeight: 200
                                                ),//should be more precise
                                                decoration: BoxDecoration(
                                                  //borderRadius: BorderRadius.circular(24.0),
                                                  color:  Colors.grey.shade200,),
                                                child:
                                                Text(
                                                    storing[index], textAlign: TextAlign.center,
                                                    maxLines: 10),
                                              )
                                          )

                                        ],
                                      ),
                                      Row(
                                        children: [
                                          // const Padding(padding: EdgeInsets.only(top:20.0,bottom: 20)),
                                          IconButton(
                                            icon: const Icon(Icons.add_circle,size: 30,color: Colors.black54,),
                                            onPressed: (){},
                                          ),
                                          const Padding(padding: EdgeInsets.only(left: 420)),
                                          IconButton(
                                            icon: const Icon(Icons.account_circle,size: 30,color: Colors.black54,),
                                            onPressed: (

                                                ){},
                                            alignment: Alignment.bottomRight,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                              );
                            }
                        ),
                      ),
                    ]
                )
            ),
          )
      );
    }
    else {
      return Scaffold(
        appBar: AppBar(
          leading: PopupMenuExample(),
          flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.black,
              ),
              title: Text('A p p N a m e '),
              centerTitle: true
          ),
          actions: [
            IconButton(
              onPressed: () {
                // _popupMenuButton(context);
              },
              icon: const Icon(Icons.account_circle_outlined,size: 30,),
              alignment: Alignment.centerLeft,
            ),
          ],
        ),
      );
    }

  }
}

class PopupMenuExample extends StatefulWidget {
  PopupMenuExample({super.key});
  @override
  State<PopupMenuExample> createState() => _PopupMenuExampleState();

}

class _PopupMenuExampleState extends State<PopupMenuExample>{
  SampleItem? selectedMenu;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading:
          PopupMenuButton<SampleItem>(
            offset: const Offset(50,50),
            initialValue: selectedMenu,
            // icon:const Icon(Icons.import_export_rounded,color: Colors.white,),
            // Callback that sets the selected popup menu item.
            onSelected: (SampleItem item) {
              setState(() {
                selectedMenu = item;
                chosen=item.toString();
              });
            },
            itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<SampleItem>>[
              const PopupMenuItem<SampleItem>(
                value: SampleItem.itemOne,
                child: Icon(Icons.insert_emoticon,color: Colors.black45),
              ),
              const PopupMenuItem<SampleItem>(
                value: SampleItem.itemTwo,
                child: Icon(Icons.science_rounded,color: Colors.black45),
              ),
              const PopupMenuItem<SampleItem>(
                value: SampleItem.itemThree,
                child: Icon(Icons.ac_unit_outlined,color: Colors.black45),
              ),
            ],
          ),

          //backgroundColor: Colors.black,
        )
    );
  }
}
String? chose()=> chosen;
