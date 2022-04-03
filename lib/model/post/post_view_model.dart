import '../enums.dart';

class PostViewModel{
  late int id;
  late int gameId;
  late String gameName;
  late String categoryName;
  late DateTime startDate;
  late DateTime finishDate;
  late String explanation;
  late int wantedCount;
  late int acceptCount;
  late List<int> acceptUserIds;
  late List<int> requestUserIds;
  late LocationType locationType;
  late PostLocation location;
  late PostTime postTime;

  PostViewModel(){
    locationType=LocationType.CLOSE;
    PostTime postTime=PostTime();
    postTime.time=1;
    postTime.timeType=PostTimeType.HOUR;
    this.postTime=postTime;
  }
}


class PostTime{
  late int time;
  late PostTimeType timeType;
}

class PostLocation{
  late double lat;
  late double long;
  late String address;
}