import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/user_info.dart';
import '../widgets/post_viewing.dart';
import 'profile_edit.dart';
import 'package:ios_proj01/widgets/profile_widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

UserInfo theuser=UserInfo();

class UserProfile extends StatefulWidget {
  final String address;
  final bool viewByOwner;
  final bool isSearchPage;

  const UserProfile({
    Key? key, 
    required this.address, 
    required this.viewByOwner,
    required this.isSearchPage,
  }) : super(key: key);
  
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final double coverHeight = 280;
  final double profileHeight = 120;
  late Future<UserInfo> userInfo;


  @override
  void initState() {
    userInfo = getProfileInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: getAppBar(),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
         FutureBuilder<UserInfo>(
            future: userInfo,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                theuser=returnuser(snapshot.data!);
                return profileBlock(snapshot.data!);
              }
              else{
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          Container(height: 12,),
          PostViewingWidget(address: widget.address),
        ],
      ),
    );
  }

  Widget profileBlock(UserInfo userInfo){
    return Column(
      children: [
        SizedBox(height: 128,),
        ProfileWidget(
          imagePath: userInfo.getImagePath(),
          onlyImage: !widget.viewByOwner,
          onClicked: (){
            if(widget.viewByOwner){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=> ProfileEdit(userInfo: userInfo))
              ).then((value) {
                setState(() {});
              });
            }
          },
        ),
        buildName(userInfo.name, userInfo.location),
      ]
    );
  }
  
  Widget buildName(name, location) => Column(
    children: [
      const SizedBox(height: 12),
      Text(//name
        name,
        style: GoogleFonts.merriweather(
            fontWeight: FontWeight.bold, fontSize: 20),
      ),
      Container(height: 6,color: Colors.transparent,),
      Text(
        '@$location',
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    ],
  );

  Future<UserInfo> getProfileInfo() async {
    final url = Uri.parse("${dotenv.env['backend_address']}/api/getUserInfo?address=${widget.address}");
    http.Response res = await http.get(url);
    final infoObject = jsonDecode(res.body);
    if (!infoObject.containsKey('name')){
      return UserInfo();
    }
    return UserInfo.fromJson(infoObject);
  }

  snackBarSuccess({String? label}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.done, color: Colors.white),
            const SizedBox(width: 10,),
            Text(label!),
          ],
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  AppBar? getAppBar() {
    if(widget.isSearchPage){
      return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.content_copy),
            tooltip: 'Copy address',
            onPressed: () {
              Clipboard.setData(ClipboardData(text: widget.address)).then((value) {
                snackBarSuccess(label: 'Copied address!');
              });
            },
          ),
        ]
      );
    }
    if(widget.viewByOwner){
      return AppBar(
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 7, sigmaX: 7),
            child: Container(
              color: Colors.transparent,
            ),
          )
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        // leading:
        title: Text(
          'Profile',
          style: GoogleFonts.abrilFatface(
              textStyle: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              )),
        ),
      );
    }
    return AppBar(
        flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 7, sigmaX: 7),
              child: Container(
                color: Colors.transparent,
              ),
            )
        ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: false,
      title: Text(
        widget.address,
        style: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black
          )
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.content_copy),
          tooltip: 'Copy address',
          onPressed: () {
            Clipboard.setData(ClipboardData(text: widget.address)).then((value) {
              snackBarSuccess(label: 'Copied address!');
            });
          },
        ),
      ]
    );
  }
}

UserInfo returnuser(userinfo){
  return userinfo;
}