import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ios_proj01/utils/user_info.dart';
import 'package:ios_proj01/widgets/profile_widget.dart';
import 'package:ios_proj01/widgets/textfield_widget.dart';
import 'package:ios_proj01/widgets/button_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

import '../providers/metamask_provider.dart';
import '../utils/blockchain.dart';


class ProfileEdit extends StatefulWidget {
  final UserInfo userInfo;

  const ProfileEdit({
    super.key, 
    required this.userInfo
  });

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  XFile? image;
  late String name;
  late String location;
  late String imagePath;

  @override
  void initState() {
    name = widget.userInfo.name;
    location = widget.userInfo.location;
    imagePath = widget.userInfo.getImagePath();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const SizedBox(height: 24,),
          ProfileWidget(
              imagePath: imagePath,
              imageFile: (image == null) ? null: File(image!.path),
              isEdit: true,
              onClicked: () {
                getImageFromDevice();
              },
          ),
          const SizedBox(height: 24,),
          TextFieldWidget(
            label: 'Name',
            text: name,
            onChanged: (data) => name = data,
          ),
          const SizedBox(height: 24,),
          TextFieldWidget(
            label: 'Location',
            text: location,
            onChanged: (data) => location = data,
          ),
          const SizedBox(height: 24,),
          ButtonWidget(
            text: 'Save',
            onClicked: (){
              upload();
              // Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  void getImageFromDevice() async{
    final picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((value) {
      setState(() {
        image = value;
      });
    });
  }

  void upload() async{
    if(image == null && widget.userInfo.imageCid == null){
      snackBarError(label: 'Please upload your profile image!');
      return;
    }
    late final String data;
    if(image != null){
      File file = File(image!.path);
      final filename = 'profile_picture${p.extension(file.path)}';
      data = jsonEncode({
        'name': name,
        'location': location,
        'filename': filename,
        'image': base64Encode(file.readAsBytesSync())
      });
    }
    else{
      data = jsonEncode({
        'name': name,
        'location': location,
        'filename': widget.userInfo.filename,
        'imageCid': widget.userInfo.imageCid
      });
    }
    
    snackBar(label: 'Uploading');
    http.Response res = await http.post(
      Uri.parse("${dotenv.env['backend_address']}/api/setUserInfo"),
      body: data,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      }
    );
    print('res.body: ${res.body}');
    String cid = res.body;
    bool success = await setUserInfoWithMetaMask(cid);
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    if(success){
      snackBarSuccess(label: "Success");
    }
    else{
      snackBarError(label: "Transaction failed!");
    }
  }


  Future<bool> setUserInfoWithMetaMask(String cid) async {
    var metamask = context.read<MetaMask>();
    var connector = metamask.connector;
    if (connector.connected) {
      try {
        EthereumWalletConnectProvider provider =
            EthereumWalletConnectProvider(connector);
        launchUrlString('wc:', mode: LaunchMode.externalApplication);
        final contract = await Blockchain.getContract('UserInfo');
        final function = contract.function("setUserInfo");
        await provider.sendTransaction(
          from: metamask.getAddress(),
          to: dotenv.env['contract_address_UserInfo'],
          data: Transaction.callContract(
            contract: contract,
            function: function,
            parameters: [cid]
          ).data,
          gas: 300000
        );
        return true;
      } catch (exp) {
        print("Error while signing transaction");
        print(exp);
        return false;
      }
    }
    return false;
  }

  snackBar({String? label}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label!),
            const CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
        duration: const Duration(days: 1),
        backgroundColor: Colors.black,
      ),
    );
  }

  snackBarError({String? label}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.close, color: Colors.white),
            const SizedBox(width: 10,),
            Text(label!),
          ],
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
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
}
