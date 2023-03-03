import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ios_proj01/providers/metamask_provider.dart';
import 'package:ios_proj01/widgets/post_viewing.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final double coverHeight = 280;
  final double profileHeight = 120;

  Future<List<dynamic>> getUserPosts(BuildContext context) async {
    final url = Uri.parse("${dotenv.env['backend_address']}/api/get-all-posts-owned-by?owner=${context.read<MetaMask>().session.accounts[0]}");
    http.Response res = await http.get(url);
    return jsonDecode(res.body);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          buildTop(),
          buildContent(context),
          const SizedBox(height: 5,),
          const PostViewingWidget(),
        ],
      ),
    );
  }

  Widget buildTop(){
    final top = coverHeight - profileHeight / 2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: profileHeight / 2),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: buildProfileImage(),
        ),
      ],
    );
  }

  Widget buildContent(BuildContext context) => Column(
    children: [
      const SizedBox(height: 8),
      Text(
        context.read<MetaMask>().session.accounts[0],
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10,),
      const Text(
        '@UserLocation',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      )
    ],
  );

  Widget buildCoverImage() => Container(
    color: Colors.grey,
    child: Image.network('https://marmotamaps.com/de/fx/wallpaper/download/faszinationen/Marmotamaps_Wallpaper_Berchtesgaden_Desktop_1920x1080.jpg',
      width: double.infinity,
      height: coverHeight,
      fit: BoxFit.cover,
    ),
  );

  Widget buildProfileImage() => CircleAvatar(
    radius: profileHeight / 2,
    backgroundColor: Colors.grey.shade800,
    backgroundImage: const AssetImage('assets/images/2.jpg')
  );
}