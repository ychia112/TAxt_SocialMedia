import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;
  final File? imageFile;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
    this.imageFile
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children:[
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(),
          ),
        ],
      ),
    );
  }

  Widget buildImage(){
    final image = (imageFile == null) ? NetworkImage(imagePath): FileImage(imageFile!) as ImageProvider;

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child:Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 120,
          height: 120,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon() => buildCircle(
        color: Colors.grey,
        all: 8,
        child: Icon(
          isEdit ? Icons.add_a_photo_rounded : Icons.edit,
          color: Colors.white,
          size: 16,
        ),
      );
  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: Colors.black87,
          child: child,
        ),
      );
}
