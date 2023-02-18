import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Login'),
      ),
      body: Center(
        child: Material(
          color: Colors.white60,
          elevation: 3,
          borderRadius: BorderRadius.circular(24),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            splashColor: Colors.black26,
            onTap: (){
              //TODO: The connection to MetaMask function
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Ink.image(
                  image: AssetImage('assets/images/metamask.svg.png'),
                  height:60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 6),
                Text(
                  'Connect to MetaMask',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(width: 12)
              ],
            ),
          ),
        ),
        ),
        );
  }
}
