import 'package:flutter/material.dart';

class UserPost extends StatefulWidget {
  const UserPost({Key? key}) : super(key: key);

  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  final _textController = TextEditingController();

  // store the input text
  String userPost = '';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 120),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // display text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      height: 200,
                      color: Colors.grey.shade200,
                      child: Center(
                        child: Text(userPost),
                      ),
                    ),
                  ),
                ),

            // input text
            TextFormField(
                minLines: 1,
                maxLines: 10,
                keyboardType: TextInputType.multiline,
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'How is your day?',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _textController.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),

            // send text
            IconButton(
              icon: const Icon(Icons.send_rounded),
              onPressed: (){
                setState(() {
                  userPost = _textController.text;
                });
              },
              color: Colors.black45,
            )
          ],
        ),
      )
    ),
    );
  }
}
