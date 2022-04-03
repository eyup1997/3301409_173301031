
class GameCategoryResModel{
  late int id;
  late String category;

  GameCategoryResModel(Map<String,dynamic> json){
    id=json["id"];
    category=json["category"];
  }

  static List<GameCategoryResModel> getInstance(List<dynamic> json){
    List<GameCategoryResModel> list=[];
    json.forEach((element) {
      list.add(GameCategoryResModel(element));
    });
    return list;
  }

}
class GameResModel{
  late int id;
  late String name;
  late GameCategoryResModel category;

  GameResModel(Map<String,dynamic> json){
    id=json["id"];
    name=json["name"];
    category=GameCategoryResModel(json["category"]);
  }

  static List<GameResModel> getInstace(List<dynamic> json){
    List<GameResModel> list=[];
    json.forEach((element) {
      list.add(GameResModel(element));
    });
    return list;
  }

}