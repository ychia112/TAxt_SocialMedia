import 'package:flutter/material.dart';

final List _userpost = <String>[];
// class userinfo(){
//   int? number;
//   final List _userpost = <String>[];
//   //final List _userpost_mood=<int>[];
// }
var emotion=<String>["joy","anger","sad","scared","annoyed","amazed","jealous"];
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


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        FocusScope.of(context).unfocus(),
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(

            flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Colors.black,
                ),
                title: const Text('Y o u r t e x t'),
                centerTitle: true
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 30,right :12, left: 12),
            child:
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height-275,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey.shade50,
                    child:
                    ListView.separated(
                        itemCount: _userpost.length,
                        padding: const EdgeInsets.only(top:15.0,bottom:15 ),
                        separatorBuilder: (BuildContext context,int index)=>
                        const Divider(height: 16,color: Color(0xFFFFFFFF)),
                        itemBuilder: (BuildContext context, int index) {
                          if ( _userpost.isEmpty){
                          }
                          else {
                            return Container(
                              //padding: const EdgeInsets.only(top:80.0,bottom: 80),//size of block
                                alignment: Alignment.center,
                                // tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.0),
                                  color:  Colors.grey.shade200,
                                ),
                                child:
                                Column(
                                  children: [
                                    Row(
                                        children: [
                                          Center(
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context).size.width-24,
                                                constraints: const BoxConstraints(
                                                    maxHeight: 250, minHeight: 200
                                                ),//should be more precise
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(24.0),
                                                  color:  Colors.grey.shade300,),
                                                child:
                                                Text(
                                                    _userpost[index], textAlign: TextAlign.center,
                                                    maxLines: 10),
                                              )
                                          ),

                                        ]
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.add_circle,size: 30,),
                                          onPressed: (){},
                                        ),
                                      ],
                                    ),
                                  ],
                                )


                            );
                          }
                        }
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children:[
                        SizedBox(
                          width: MediaQuery.of(context).size.width-80,
                          height: 80,
                          child:
                          TextFormField(
                            minLines: 1,
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            controller: _textController,
                            decoration: InputDecoration(
                              hintText: 'How is your day?',
                              //contentPadding: const EdgeInsets.all(18.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide:
                                const BorderSide( width: 3,color: Colors.black12),
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
                        ),
                        SizedBox(
                          width: 40,
                          height: 60,
                          child: IconButton(
                            icon: const Icon(Icons.send_rounded),
                            onPressed: (){
                              setState(() {
                                userPost=_textController.text;
                                _textController.clear();
                                _userpost.add(userPost) ;
                                timecount++;
                              });
                            },
                            color: Colors.black45,
                            alignment: Alignment.centerRight,
                          ),
                        ),
                      ]
                  ),
                  // display text
                  // input text
                  // send text
                ],
              ),
            ),


          )
      ),

    );
  }
}

List store()=> _userpost;