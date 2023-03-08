import 'mood.dart';
import 'user_info.dart';

class Post{
  late UserInfo userInfo;
  late PostContext context;

  Post({required this.userInfo, required this.context});
}

class PostContext{
  late String author;
  late String text;
  late Mood mood;
  late String? datetime;

  PostContext({required this.author, required this.text, required mood, this.datetime});

  PostContext.fromJson(dynamic jsonObject){
    author = jsonObject['author'];
    text = jsonObject['context'];
    mood = Mood.values[jsonObject['mood']];
    datetime = jsonObject.containsKey('datetime')? jsonObject['datetime']: "";
  }
}