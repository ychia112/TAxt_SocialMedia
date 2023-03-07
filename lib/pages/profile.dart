import 'package:flutter/material.dart';
import 'package:ios_proj01/providers/metamask_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/post_viewing.dart';
import 'profile_edit.dart';
import 'package:ios_proj01/utils/user_preferences.dart';
import 'package:ios_proj01/widgets/profile_widget.dart';
import 'package:ios_proj01/model/user.dart';

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
    final user = UserPreferences.getUser();

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
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async{
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=> ProfileEdit())
              );
              setState(() {});
            },
          ),
          buildName(user),
          Container(height: 12,),
          PostViewingWidget(address: context.read<MetaMask>().session.accounts[0]),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          const SizedBox(height: 8),
          Text(//name
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Container(height: 6,color: Colors.transparent,),
          Text(
            user.address,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 10,),
        ],
      );
}