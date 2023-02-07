import 'package:flutter/material.dart';

final List _userpost = <String>[];
int timecount=0;

class UserPost extends StatefulWidget {
  const UserPost({Key? key}) : super(key: key);
  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  final _textController = TextEditingController();
  // store the input text
  String userPost = '';
  //final List _userpost = <String>[];


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        FocusScope.of(context).unfocus(),
      },
      child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 90),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // display text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                  child: Container(
                    height: 450,
                    color: Colors.grey.shade200,
                    child:
                        ListView.separated(
                        itemCount: _userpost.length,
                        padding: const EdgeInsets.only(top:15.0),
                        separatorBuilder: (BuildContext context,int index)=>
                          const Divider(height: 16,color: Color(0xFFFFFFFF)),

                        itemBuilder: (BuildContext context, int index) {
                          if (_userpost.isEmpty){
                          }
                          else {
                            return Container(
                              padding: const EdgeInsets.all(16.0),
                              alignment: Alignment.center,
                              // tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.black12,
                              ),
                              child: Text(
                                  _userpost[index], textAlign: TextAlign.left,
                                  maxLines: 10),
                            );

                            }
                          }

                      ),
                    ),
            ),
            // input text
            TextFormField(
                minLines: 1,
                maxLines: 3,
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
                  userPost=_textController.text;
                  _userpost.add(_textController.text) ;
                  timecount++;
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

List store()=>_userpost;


