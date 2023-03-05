import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'post.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/post_viewing.dart';

List num=[];
class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);
  @override
  State<UserHome> createState() => _UserHome();
}

class _UserHome extends State<UserHome> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
            dotenv.env['app_name']!,
            style: GoogleFonts.abrilFatface(
              textStyle: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.black
              )
            ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserPost()),
              );
            },
            icon: const Icon(Icons.post_add_rounded,size: 30,),
            alignment: Alignment.centerLeft,
            color: Colors.black,
          ),
        ],
      ),
      body: ListView(
        children:const [PostViewingWidget()]
      ),
    );
  }
}

List postnum (){
  return num;
}