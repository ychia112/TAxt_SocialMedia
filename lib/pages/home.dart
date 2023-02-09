import 'package:flutter/material.dart';
import 'post.dart';
var storing = store();

class UserHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (storing.isNotEmpty){
      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_box_outlined,size: 30,),
              alignment: Alignment.center,
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.black,
              ),
              title: const Text('A p p N a m e '),
              centerTitle: true
            ),
            actions: [
              IconButton(
                onPressed: () {},
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
                                  onPressed: (){},
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
             // slivers: [
                // SliverAppBar(
                //   pinned: true,
                //   flexibleSpace: FlexibleSpaceBar(
                //     background: Container(
                //       color: Colors.black,
                //     ),
                //     title: const Text('A p p N a m e '),
                //   ),
                // ),
              //   SliverSafeArea(sliver:
              //     SliverGrid(
              //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //           crossAxisCount: 1,
              //           crossAxisSpacing: 15,
              //           mainAxisSpacing:15,
              //           childAspectRatio: 3
              //       ),
              //       delegate: SliverChildBuilderDelegate(
              //             (BuildContext context, int index) {
              //               const Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10));
              //           return Container(
              //             //padding: const EdgeInsets.only(top:80.0,bottom: 80),//size of block
              //             alignment: Alignment.center,
              //             // tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(24.0),
              //               color:  Colors.grey.shade200,
              //             ),
              //             child:
              //             Column(
              //               children: [
              //                 Row(
              //                   children: [
              //                     Padding(
              //                         padding: const EdgeInsets.only(top:80.0,bottom: 80),
              //                       child:Text("${storing[index]}",),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     IconButton(
              //                       icon: const Icon(Icons.add_circle,size: 5,),
              //                       onPressed: (){},
              //                     ),
              //                   ],
              //                 ),
              //
              //               ],
              //             ),
              //
              //           );
              //         },
              //         childCount:storing.length,
              //       ),
              //     ),
              //

              ]
                // SliverToBoxAdapter(
                //     child: Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                //         child: ClipRRect(
                //           borderRadius: BorderRadius.circular(24),
                //           child: Container(
                //             height: 200,
                //             color: Colors.grey.shade200,
                //
                //           ),
                //
                //         )
                //     )
                // ),


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

