import 'package:flutter/material.dart';
import 'package:flutter/dataset.dart';
import 'package:story/story.dart';

class StoryViewer extends StatelessWidget {
  final List<Story> storyList;
  StoryViewer({required this.storyList});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StoryPageView(
          itemBuilder: (context, pageIndex, storyIndex) {
            final user = storyList[pageIndex];
            final story = storyList[pageIndex].stories[storyIndex];
            return Stack(
              children: [
                Positioned.fill(
                  child: Container(color: Colors.black),
                ),
                Positioned.fill(
                  child: Image.network(
                    story.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 8),
                  child: Row(
                    children: [
                      Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(user.image),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        user.name,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          gestureItemBuilder: (context, pageIndex, storyIndex) {
            return Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
          pageLength: storyList.length,
          storyLength: (int pageIndex) {
            return storyList[pageIndex].stories.length;
          },
          onPageLimitReached: () {
            Navigator.pop(context);
          },
        ));
  }
}