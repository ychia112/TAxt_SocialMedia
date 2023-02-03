import 'package:dashed_circle/dashed_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/dataset.dart';
import 'package:flutter/storyView.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              height: 102,
              child: StoryWidget(),
            ),
            Flexible(
              child: PostWidget(),
            )
          ],
        ),
      ),
    );
  }
}

class StoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: storyList.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0)
          return Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[900],
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  radius: 40,
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Your Story")
              ],
            ),
          );
        else
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (_, __, ___) =>
                        StoryViewer(storyList: storyList)),
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 2, bottom: 2),
                    child: DashedCircle(
                      dashes: storyList[index - 1].stories.length,
                      gapSize:
                      storyList[index - 1].stories.length == 1 ? 0 : 1.5,
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[900],
                          backgroundImage:
                          NetworkImage(storyList[index - 1].image),
                          radius: 34,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(storyList[index - 1].name)
                ],
              ),
            ),
          );
      },
    );
  }
}

class PostWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: postList.length,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        child: CircleAvatar(
                          backgroundImage:
                          NetworkImage(postList[index].profile),
                          radius: 26,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              postList[index].name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            Text(
                              postList[index].time,
                              style: TextStyle(color: Colors.white54),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.more_horiz)
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                postList[index].title,
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  height: 250,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: NetworkImage(postList[index].image),
                          fit: BoxFit.cover)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 24,
                            color: postList[index].likeStatus
                                ? Colors.red
                                : Colors.white70,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            postList[index].like.toString(),
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              color: Colors.white70,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.messenger_outline,
                            size: 24,
                            color: Colors.white70,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            postList[index].comment.toString(),
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              color: Colors.white70,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Transform.rotate(
                    angle: -0.6,
                    child: Icon(
                      Icons.send,
                      size: 23,
                      color: Colors.white70,
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}