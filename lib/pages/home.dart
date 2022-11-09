import 'package:airplane/pages/video_page.dart';
import 'package:flutter/material.dart';
import 'package:airplane/api/web_service.dart';
import 'package:airplane/model/bannerModel.dart';
import 'package:airplane/model/cat_list.dart';
import 'package:airplane/model/video_model.dart';
import 'category_page.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<BannerModel>> bannerModel=WebService.getBanner();
  Future<List<CatList>> catList=WebService.getCatList();
  Future<List<VideoModel>> latestVideo=WebService.getVideo();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WebService.getBanner();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Type of Airplanes'),
        centerTitle: true,
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
              children: [
                FutureBuilder<List<BannerModel>>(
                    future: bannerModel,
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        return SizedBox(
                          height: 130,
                          child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context,index){
                                return SizedBox(
                                  height: 130,
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    child: Image.network(snapshot.data![index].bannerImage!,fit: BoxFit.cover,),
                                  ),
                                );
                              }),
                        );
                      }
                      else{
                        return const CircularProgressIndicator();
                      }
                    }
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text('دسته بندی انواع هواپیماها',style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold,color: Colors.green,),),
                FutureBuilder<List<CatList>>(
                    future: catList,
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        return SizedBox(
                          height: 210,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context,index){
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryPage(catList: snapshot.data![index],)));
                                  },
                                  child: SizedBox(
                                      height: 200,
                                      width: 250,
                                      child: Card(
                                        child: Column(
                                          children: [
                                            Text(snapshot.data![index].categoryName!,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                            Image.network(snapshot.data![index].categoryImage!,fit: BoxFit.cover,)
                                          ],
                                        ),
                                      )
                                  ),
                                );
                              }
                          ),
                        );
                      }
                      else
                      {
                        return const CircularProgressIndicator();
                      }
                    }
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text('آخرین ویدیوها',style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold,color: Colors.green,),),
                FutureBuilder<List<VideoModel>>(
                    future: latestVideo,
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        return SizedBox(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context,index){
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPage(videoModel: snapshot.data![index])));
                                  },
                                  child: SizedBox(
                                    width: 300,
                                    height: 320,
                                    child: Card(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(snapshot.data![index].videoTitle!,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.red),),
                                          Image.network(snapshot.data![index].videoThumbNailB!,height: 250,width: 400,fit: BoxFit.cover,),
                                          const SizedBox(
                                            height: 2,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                          ),
                        );
                      }
                      else{
                        return const CircularProgressIndicator();
                      }
                    }
                ),
              ]
          ),
        ),
      ),
    );
  }
}
