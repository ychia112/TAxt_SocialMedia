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
import 'package:ios_proj01/widgets/textfield_widget.dart';

class NewDiary extends StatefulWidget {
  @override
  State<NewDiary> createState() => _NewDiaryState();
}

class _NewDiaryState extends State<NewDiary> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title:Text(
            'New Diary',
            style: GoogleFonts.abrilFatface(
              textStyle: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              )
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children:[
          SizedBox(height: 12,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'To :',
              style: GoogleFonts.abrilFatface(
                  textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )
              ),
            ),
          ),
          SizedBox(height: 12,),
            TextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines:3,
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Send to',
                hintStyle: GoogleFonts.merriweather(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black
                    )),
                filled: true,
                fillColor:Colors.white70,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide:
                  const BorderSide( width: 2,color: Colors.black12),
                ),
                focusedBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide:
                  const BorderSide( width: 2,color: Colors.black12),
                ),
                prefixIconConstraints: const BoxConstraints(
                    minWidth: 8
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    _textController.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
          SizedBox(height: 12,),
          TextFormField(
            keyboardType: TextInputType.multiline,
            minLines: 20,
            maxLines:50,
            controller: _textController,
            decoration: InputDecoration(
              hintText: '',
              hintStyle: GoogleFonts.merriweather(
                  textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black
                  )),
              filled: true,
              fillColor:Colors.white70,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.0),
                borderSide:
                const BorderSide( width: 2,color: Colors.black12),
              ),
              focusedBorder:OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.0),
                borderSide:
                const BorderSide( width: 2,color: Colors.black12),
              ),
              prefixIconConstraints: const BoxConstraints(
                  minWidth: 8
              ),
            ),
          ),
          SizedBox(height: 12,),
          ButtonWidget(
            text: 'Send',
            onClicked: (){
            },
          )
        ],
      ),
    ),
    );
  }
}
