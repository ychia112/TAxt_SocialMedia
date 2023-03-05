import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ios_proj01/model/user.dart';
import 'package:ios_proj01/utils/user_preferences.dart';
import 'package:ios_proj01/widgets/profile_widget.dart';
import 'package:ios_proj01/widgets/textfield_widget.dart';
class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState()  => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  User user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Edit Profile',
          style: GoogleFonts.abrilFatface(
              textStyle: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              )),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        children: [
          const SizedBox(height: 24,),
          ProfileWidget(
              imagePath: user.imagePath,
              isEdit: true,
              onClicked: () async{},
          ),
          const SizedBox(height: 24,),
          TextFieldWidget(
            label: 'Name',
            text: user.name,
            onChanged: (name){},
          ),
          const SizedBox(height: 24,),
          TextFieldWidget(
            label: 'Location',
            text: user.address,
            onChanged: (address){},
          ),
        ],
      ),
    );
  }
}
