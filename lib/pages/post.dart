import 'package:flutter/material.dart';
import 'home.dart';

final List _userpost = <String>["hello world",];
int timecount=3;
var chosenmood=chose();

class UserPost extends StatefulWidget {
  const UserPost({Key? key}) : super(key: key);
  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  final _textController = TextEditingController();
  // store the input text
  String userPost = '';
  Icon updateicon(int num){
    if(num==1)
    {
      return const Icon(Icons.insert_emoticon,color: Colors.black,size: 30,);
    }
    else if (num==2){
      return const Icon(Icons.emoji_emotions_rounded,color: Colors.black,size: 30,);
    }
    else if (num==3){
      return const Icon(Icons.favorite_border_outlined,color: Colors.black,size: 30,);
    }
    else if (num==4){
      return const Icon(Icons.favorite_outlined,color: Colors.black,size: 30,);
    }
    else{
      return const Icon(Icons.add_circle,size: 30,);
    }
  }
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
          body:
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(12),
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
                              padding: const EdgeInsets.only(top:5.0,bottom:15 ),
                              separatorBuilder: (BuildContext context,int index)=>
                              const Divider(height: 16,color: Color(0xFFFFFFFF)),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    alignment: Alignment.center,
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
                                              children:[
                                                SizedBox(
                                                    height:40,
                                                    width:45,
                                                    child:updateicon(chosenmood[index]),
                                                )
                                              ]
                                          )
                                        ],
                                      ),
                                  );
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
                  ),)

                ],
              )

          )
      );


  }

}

List store()=> _userpost;


