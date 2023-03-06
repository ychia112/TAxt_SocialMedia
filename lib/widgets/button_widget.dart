import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.grey,
      shape: StadiumBorder(),
      onPrimary: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
    ),
    child: Text(
      text,
      style: GoogleFonts.abrilFatface(
        textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.white
        )),
    ),

    onPressed: onClicked,
  );
}