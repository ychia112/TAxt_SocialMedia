import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ios_proj01/pages/post.dart';
import 'package:ios_proj01/providers/metamask_provider.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import '../utils/mood.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final double coverHeight = 280;
  final double profileHeight = 120;

  Future<List<dynamic>> getUserPosts(BuildContext context) async {
    final url = Uri.parse("${dotenv.env['backend_address']}/api/get-all-posts-owned-by?owner=${context.read<MetaMask>().session.accounts[0]}");
    http.Response res = await http.get(url);
    return jsonDecode(res.body);
  }
  
  @override
  Widget build(BuildContext context) {
    final top = coverHeight - profileHeight / 2;
    late final Future<List<dynamic>> _posts = getUserPosts(context);

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildContent(),
          const SizedBox(height: 30,),
          buildPosts(_posts),
        ],
      ),
    );
  }

  Widget buildTop(){
    final top = coverHeight - profileHeight / 2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: profileHeight / 2),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: buildProfileImage(),
        ),
      ],
    );
  }

  Widget buildContent() => Column(
    children: const [
      SizedBox(height: 8),
      Text(
        'UserName',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      Text(
        '@UserLocation',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      )
    ],
  );
  Widget buildCoverImage() => Container(
    color: Colors.grey,
    child: Image.network('https://marmotamaps.com/de/fx/wallpaper/download/faszinationen/Marmotamaps_Wallpaper_Berchtesgaden_Desktop_1920x1080.jpg',
      width: double.infinity,
      height: coverHeight,
      fit: BoxFit.cover,
    ),
  );

  Widget buildProfileImage() => CircleAvatar(
    radius: profileHeight / 2,
    backgroundColor: Colors.grey.shade800,
    backgroundImage: AssetImage('assets/images/2.jpg')
  );

  Widget buildPosts(_posts) => FutureBuilder<List<dynamic>>(
    future: _posts,
    builder: (context, snapshot) {
      if(snapshot.hasData){
        return SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const MyStatefulWidget(),
              Container(
                height: MediaQuery.of(context).size.height-260,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade50,
                child:
                ListView.separated(
                  itemCount: snapshot.data!.length,
                  padding: const EdgeInsets.only(top:5.0,bottom:15.0),
                  separatorBuilder: (BuildContext context,int index)=>
                  const Divider(height: 16,color: Color(0xFFFFFFFF)),
                  itemBuilder: (BuildContext context, int index) {
                    if(chosen.length < snapshot.data!.length) {
                      chosen.add(0);
                    }
                    return Container(
                      alignment: Alignment.center,
                      // tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        color:  Colors.grey.shade300,
                      ),
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children:[
                              const Padding(padding: EdgeInsets.only(top:60.0,left: 10)),
                              ClipOval(
                                child:
                                Image.asset('assets/images/2.jpg',width: 50,height: 50,fit: BoxFit.cover,)
                              ),
                            ],
                          ),
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
                                    //borderRadius: BorderRadius.circular(24.0),
                                    color:  Colors.grey.shade200,),
                                  child:
                                  Text(
                                      snapshot.data![index]['context'], textAlign: TextAlign.center,
                                      maxLines: 10),
                                )
                              )
                            ],
                          ),
                          Row(
                            children: [
                              // const Padding(padding: EdgeInsets.only(top:20.0,bottom: 20)),
                              SizedBox(
                                width: 40,
                                height: 40,
                                //color: Colors.black26,
                                child: updateicon(chosen[index]),
                              )

                              // Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width-124)),
                              // IconButton(
                              //   icon: const Icon(Icons.account_circle,size: 30,color: Colors.black54,),
                              //   onPressed: (){
                              //
                              //   },
                              //   alignment: Alignment.bottomRight,
                              // ),
                            ],
                          ),
                        ],
                      )
                    );
                  }
                ),
              ),
            ]
          )
        );
      }
      else{
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ],
          ),
        );
      }
    },
  );
}