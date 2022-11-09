import 'package:airplane/model/bannerModel.dart';
import 'package:http/http.dart' as http;
import '../model/cat_list.dart';
import '../model/get_cat_video.dart';
import '../model/video_model.dart';
import 'json_parser.dart';
class WebService{
  static Future<List<BannerModel>> getBanner() async {
    List<BannerModel> bannersList = [];
    String url = 'http://mobilemasters.ir/apps/airplane/api.php?home_banner';
    var address = Uri.parse(url);
    await http.get(address);
    http.Response response = await http.get(address);
    if (response.statusCode == 200) {
      bannersList = JsonParser.getBanner(response);
    }
    return bannersList;
  }
  static Future<List<CatList>> getCatList() async{
    List<CatList> catList=[];
    String url='http://mobilemasters.ir/apps/airplane/api.php?cat_list';
    var address=Uri.parse(url);
    await http.get(address);
    http.Response response=await http.get(address);
    if(response.statusCode==200)
    {
      catList=JsonParser.getCatList(response);
    }
    return catList;
  }
  static Future<List<VideoModel>> getVideo() async{
    List<VideoModel> videoModel=[];
    String url='http://mobilemasters.ir/apps/airplane/api.php?All_videos';
    var address=Uri.parse(url);
    await http.get(address);
    http.Response response=await http.get(address);
    if(response.statusCode==200){
      videoModel=JsonParser.getVideo(response);
    }
    return videoModel;
  }
  static Future<List<GetCatVideo>> getCatVideo(String id) async{
    List<GetCatVideo> getCatVideo=[];
    String url='http://mobilemasters.ir/apps/airplane/api.php?cat_id=$id';
    var address=Uri.parse(url);
    await http.get(address);
    http.Response response=await http.get(address);
    if(response.statusCode==200){
      getCatVideo=JsonParser.getCatVideo(response);
    }
    return getCatVideo;
  }
}
