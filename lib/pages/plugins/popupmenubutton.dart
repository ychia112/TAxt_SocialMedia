import 'package:flutter/material.dart';

// class FMPopupMenuButtonVC extends StatefulWidget{
//   @override
//   FMPopupMenuButtonState createState() => FMPopupMenuButtonState();
// }

// class FMPopupMenuButtonState extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("IconButton"),
//         actions: [_popupMenuButton(context)],
//       ),
//     );
//   }

PopupMenuButton _popupMenuButton(BuildContext context){
  return PopupMenuButton(
    itemBuilder: (BuildContext context){
      return [
        PopupMenuItem(child: Text("server1"),value: "server1",),
        PopupMenuItem(child: Text("server2"),value: "server2",),
        PopupMenuItem(child: Text("server3"),value: {"server3"},),
      ];
    },
  );
}

