import 'package:gelirim/dao/api/model/auth/jwt.dart';
import 'package:gelirim/dao/api/model/post/game.dart';
import 'package:gelirim/dao/api/model/post/post_req_model.dart';
import 'package:gelirim/dao/api/model/post/post_res_model.dart';
import 'package:gelirim/dao/api/post_api.dart';
import 'package:gelirim/model/post/game_view_model.dart';
import 'package:gelirim/model/post/post_view_model.dart';
import 'package:gelirim/service/user_service.dart';

class PostService{
  final UserService  _userService=UserService();
  static final PostService _service=PostService._internal();
  factory PostService(){
    return _service;
  }
  PostService._internal();
  final PostApi _postApi=PostApi();
  Future<List<GameCategoryViewModel>> getAllCategory()async{
    List<GameCategoryViewModel> list=[];
    List<GameCategoryResModel>? res=await _postApi.getAllCategory();
    if(res!=null){
      res.forEach((element) {
        GameCategoryViewModel viewModel=GameCategoryViewModel();
        viewModel.category=element.category;
        viewModel.id=element.id;
        list.add(viewModel);
      });
    }
    return list;
  }
  Future<List<GameViewModel>> getByCat(GameCategoryViewModel viewModel)async{
    List<GameViewModel> list=[];
    var res=await _postApi.getGamesByCatId(viewModel.id);
    if(res!=null){
      res.forEach((element) {
        GameViewModel model=GameViewModel();
        model.id=element.id;
        model.name=element.name;
        model.category=GameCategoryViewModel();
        model.category.category=element.category.category;
        model.category.id=element.category.id;
        list.add(model);
      });
    }
    return list;
  }

  Future<PostViewModel?> savePost(PostViewModel viewModel)async{
    JWT jwt=await _userService.getJWT();
    PostReqModel reqModel=PostReqModel();
    reqModel.gameId=viewModel.gameId;
    reqModel.locationType=viewModel.locationType;
    reqModel.postTime=viewModel.postTime.time;
    reqModel.timeType=viewModel.postTime.timeType;
    reqModel.startDate=viewModel.startDate;
    reqModel.finishDate=viewModel.finishDate;
    reqModel.address=viewModel.location.address;
    reqModel.wantedCount=viewModel.wantedCount;
    reqModel.longitude=viewModel.location.long;
    reqModel.latitude=viewModel.location.lat;
    reqModel.explanation=viewModel.explanation;
  var res= await _postApi.savePost(jwt, reqModel);
      if(res){
        var response=await _postApi.getAuthLastPost(jwt);
        if(response!=null){
          print(response.categoryName+"---"+response.gameName+"--"+response.address);
          PostViewModel model=PostViewModel();
          model.id=response.id;
          model.gameName=response.gameName;
          model.categoryName=response.categoryName;
          model.acceptCount=response.acceptCount;
          model.explanation=response.explanation;
          model.wantedCount=response.wantedCount;
          return model;
        }
      }
      return null;
  }
  Future<PostViewModel?> getPost(int id)async{
    JWT jwt=await _userService.getJWT();

      var response=await _postApi.getAuthPost(jwt,id);
      if(response!=null){
        PostViewModel model=PostViewModel();
        model.id=response.id;
        model.gameName=response.gameName;
        model.categoryName=response.categoryName;
        model.acceptCount=response.acceptCount;
        model.explanation=response.explanation;
        model.wantedCount=response.wantedCount;
        return model;
      }
    return null;
  }
  Future<List<PostViewModel>?> getAuthPost()async{
    JWT jwt=await _userService.getJWT();
    var res=await _postApi.getAuthPosts(jwt);
    if(res!=null){
      List<PostViewModel> viewModels=[];
      res.forEach((element) {
        PostViewModel model=PostViewModel();
        model.id=element.id;
        model.gameName=element.gameName;
        model.categoryName=element.categoryName;
        model.acceptCount=element.acceptCount;
        model.explanation=element.explanation;
        model.wantedCount=element.wantedCount;
        viewModels.add(model);
      });
      return viewModels;
    }

    return null;
  }
}