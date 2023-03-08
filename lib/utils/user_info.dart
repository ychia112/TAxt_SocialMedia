class UserInfo{
  late String name;
  late String location;
  late String? imageCid;
  late String? filename;

  UserInfo({String? name, String? location, this.imageCid, this.filename}){
    this.name = name ?? 'Name(default)';
    this.location = location ?? 'Location(default)';
  }

  UserInfo.fromJson(dynamic jsonObject){
    name = jsonObject['name'];
    location = jsonObject['location'];
    imageCid = jsonObject['imageCid'];
    filename = jsonObject['filename'];
  }

  String getImagePath(){
    if(imageCid == null){
      return 'https://shayarimaza.com/files/boys-dp-images/sad-boy-dp-images/Sad-boy-Profile-Pic.jpg';
    }
    return 'https://$imageCid.ipfs.w3s.link/$filename';
  }
}