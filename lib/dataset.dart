class Story {
  final String name;
  final String image;
  final int number;
  final List<StoryModel> stories;
  Story(
      {required this.name,
        required this.image,
        required this.number,
        required this.stories});
}

List<Story> storyList = [
  Story(
      name: "Govind",
      image: "http://lorempixel.com/200/200/people/5",
      number: 2,
      stories: [
        StoryModel("http://lorempixel.com/200/400/people"),
        StoryModel("http://lorempixel.com/200/400/nature")
      ]),
  Story(
      name: "Keshav",
      image: "http://lorempixel.com/200/200/people/1",
      number: 3,
      stories: [
        StoryModel("http://lorempixel.com/200/400/people"),
        StoryModel("http://lorempixel.com/200/400/nature"),
        StoryModel("http://lorempixel.com/200/400/nature/1")
      ]),
  Story(
      name: "Sahil",
      image: "http://lorempixel.com/200/200/people/2",
      number: 5,
      stories: [
        StoryModel("http://lorempixel.com/200/400/people"),
        StoryModel("http://lorempixel.com/200/400/nature/1"),
        StoryModel("http://lorempixel.com/200/400/nature/2"),
        StoryModel("http://lorempixel.com/200/400/nature/3"),
        StoryModel("http://lorempixel.com/200/400/nature/4")
      ]),
  Story(
      name: "Manas",
      image: "http://lorempixel.com/200/200/people/3",
      number: 2,
      stories: [
        StoryModel("http://lorempixel.com/200/400/people"),
        StoryModel("http://lorempixel.com/200/400/nature")
      ]),
  Story(
      name: "Prajjwal",
      image: "http://lorempixel.com/200/200/people/4",
      number: 1,
      stories: [
        StoryModel("http://lorempixel.com/200/400/people"),
      ])
];

class Post {
  final String name;
  final String profile;
  final String time;
  final String title;
  final String image;
  final int like;
  final bool likeStatus;
  final int comment;

  Post(
      {required this.name,
        required this.profile,
        required this.time,
        required this.title,
        required this.image,
        required this.like,
        this.likeStatus = false,
        required this.comment});
}

List<Post> postList = [
  Post(
      name: "Govind",
      profile: "http://lorempixel.com/200/200/people/5",
      time: "08:16 pm",
      title: "I have been Coding whole night",
      image: "http://lorempixel.com/400/250/technics/9",
      like: 1341,
      likeStatus: true,
      comment: 76),
  Post(
      name: "Keshav",
      profile: "http://lorempixel.com/200/200/people/1",
      time: "09:26 pm",
      title: "Food == Love",
      image: "http://lorempixel.com/400/250/food/9",
      like: 131,
      comment: 76),
  Post(
      name: "Sahil",
      profile: "http://lorempixel.com/200/200/people/2",
      time: "12:26 am",
      title: "Game Night!!!",
      image: "http://lorempixel.com/400/250/sports/9",
      like: 341,
      comment: 36),
  Post(
      name: "Manas",
      profile: "http://lorempixel.com/200/200/people/3",
      time: "04:36 pm",
      title: "Love Animals",
      image: "http://lorempixel.com/400/250/animals/9",
      like: 134,
      likeStatus: true,
      comment: 96),
  Post(
      name: "Prajjwal",
      profile: "http://lorempixel.com/200/200/people/4",
      time: "02:44 am",
      title: "Nature",
      image: "http://lorempixel.com/400/250/nature",
      like: 541,
      comment: 176)
];

class StoryModel {
  StoryModel(this.imageUrl);
  final String imageUrl;
}