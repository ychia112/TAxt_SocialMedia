import 'mood.dart';

class Post{
  late String author;
  late String context;
  late Mood mood;
  late String? datetime;

  Post({required this.author, required this.context, required mood, this.datetime});

  Post.fromJson(dynamic jsonObject){
    author = jsonObject['author'];
    context = jsonObject['context'];
    mood = Mood.values[jsonObject['mood']];
    datetime = jsonObject.containsKey('datetime')? jsonObject['datetime']: "";
  }
}