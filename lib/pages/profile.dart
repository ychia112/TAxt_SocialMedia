import 'package:flutter/material.dart';

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
    final top = coverHeight - profileHeight / 2;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildContent(),
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

  Widget buildContent() => Column(
    children: [
      const SizedBox(height: 8),
      const Text(
        'UserName',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Container(
              height: 200,
              color: Colors.grey.shade200,
            ),
          )
      ),
    ],

  );
  Widget buildCoverImage() => Container(
    color: Colors.grey,
    child: Image.network('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
      width: double.infinity,
      height: coverHeight,
      fit: BoxFit.cover,
    ),
  );

  Widget buildProfileImage() => CircleAvatar(
    radius: profileHeight / 2,
    backgroundColor: Colors.grey.shade800,
    backgroundImage: const NetworkImage(
        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
    ),
  );
}
