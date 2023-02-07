import 'package:flutter/material.dart';
import 'post.dart';
var storing = store();

class UserHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (storing.isNotEmpty){
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
                SliverSafeArea(sliver:
                  SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            const Padding(padding: EdgeInsets.symmetric(horizontal: 32, vertical: 6));
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            color: Colors.grey.shade200,
                            alignment: Alignment.center,
                            child:Text("${storing[index]}"),
                          )
                        );
                      },
                      childCount:storing.length,

                    ),
                  ),

                ),
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

