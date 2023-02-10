import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'post.dart';

var storing = store();
>>>>>>> origin/new_interface_for_home_and_post

class UserHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
=======
    if (storing.isNotEmpty){
      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
              },
              icon: const Icon(Icons.add_box_outlined,size: 30,),
              alignment: Alignment.center,
            ),
>>>>>>> origin/new_interface_for_home_and_post
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.black,
              ),
<<<<<<< HEAD
              title: Text('A p p N a m e'),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  height: 200,
                  color: Colors.grey.shade200,
                ),
              )
            )
          ),
          SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      height: 200,
                      color: Colors.grey.shade200,
                    ),
                  )
              )
          ),
          SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      height: 200,
                      color: Colors.grey.shade200,
                    ),
                  )
              )
          ),
          SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      height: 200,
                      color: Colors.grey.shade200,
                    ),
                  )
              )
          ),
        ]
      )
    );
  }
}
=======
              title: const Text('A p p N a m e '),
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
          body: CustomScrollView(
          slivers: [
              SliverAppBar(
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                background: Container(
                color: Colors.black,
                ),
                title: Text('A p p N a m e '),
                ),

          ),
          ],
        ),
      );
    }

  }
}

// PopupMenuButton _popupMenuButton(BuildContext context){
//   SampleItem? selectedMenu;
//   PopupMenuButton<SampleItem>(
//     initialValue: selectedMenu,
//     // Callback that sets the selected popup menu item.
//     onSelected: (SampleItem item) {
//       setState(() {
//         selectedMenu = item;
//       });
//     },
//     itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
//       const PopupMenuItem<SampleItem>(
//         value: SampleItem.itemOne,
//         child: Text('Item 1'),
//       ),
//       const PopupMenuItem<SampleItem>(
//         value: SampleItem.itemTwo,
//         child: Text('Item 2'),
//       ),
//       const PopupMenuItem<SampleItem>(
//         value: SampleItem.itemThree,
//         child: Text('Item 3'),
//       ),
//     ],
//   ),
//   ),
//
//   );
// }
>>>>>>> origin/new_interface_for_home_and_post
