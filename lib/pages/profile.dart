import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ios_proj01/providers/metamask_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/user_info.dart';
import '../widgets/post_viewing.dart';
import 'profile_edit.dart';
import 'package:ios_proj01/utils/user_preferences.dart';
import 'package:ios_proj01/widgets/profile_widget.dart';
import 'package:ios_proj01/model/user.dart';
import 'package:http/http.dart' as http;

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);
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
    // final user = UserPreferences.getUser();

    return Scaffold(
      appBar: AppBar(
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
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
         FutureBuilder<UserInfo>(
            future: userInfo,
            builder: (context, snapshot) {
              if(snapshot.hasData){
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
          PostViewingWidget(address: context.read<MetaMask>().getAddress()),
        ],
      ),
    );
  }

  Widget profileBlock(UserInfo userInfo){
    return Column(
      children: [
        ProfileWidget(
          imagePath: userInfo.getImagePath(),
          onClicked: () async{
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=> ProfileEdit(userInfo: userInfo))
            );
            setState(() {});
          },
        ),
        buildName(userInfo.name, userInfo.location),
      ]
    );
  }
  
  Widget buildName(name, location) => Column(
    children: [
      const SizedBox(height: 8),
      Text(//name
        name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      Container(height: 6,color: Colors.transparent,),
      Text(
        '@$location',
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
      const SizedBox(height: 10,),
    ],
  );

  Future<UserInfo> getProfileInfo() async {
    final url = Uri.parse("${dotenv.env['backend_address']}/api/getUserInfo?address=${context.read<MetaMask>().getAddress()}");
    http.Response res = await http.get(url);
    final infoObject = jsonDecode(res.body);
    if (!infoObject.containsKey('name')){
      return UserInfo();
    }
    return UserInfo.fromJson(infoObject);
  }
}