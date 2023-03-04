import 'package:flutter/material.dart';
import 'package:ios_proj01/providers/metamask_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/post_viewing.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final double coverHeight = 280;
  final double profileHeight = 120;

  @override
  Widget build(BuildContext context) {
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
          buildProfileImage(),
          buildContent(),
          Container(height: 12,),
          const PostViewingWidget(),
        ],
      ),
    );
  }

  Widget buildContent() => Column(
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

  Widget buildProfileImage() => CircleAvatar(
    radius: profileHeight / 2,
    backgroundColor: Colors.grey.shade800,
    backgroundImage: const AssetImage('assets/images/2.jpg')
  );
}