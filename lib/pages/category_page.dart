import 'package:airplane/api/web_service.dart';
import 'package:airplane/model/cat_list.dart';
import 'package:airplane/model/get_cat_video.dart';
import 'package:airplane/pages/video_page_detail.dart';
import 'package:flutter/material.dart';
class CategoryPage extends StatefulWidget {
  final CatList catList;
  const CategoryPage({Key? key,required this.catList,}) : super(key: key);
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}
class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    Future<List<GetCatVideo>> getCatVideo=WebService.getCatVideo(widget.catList.cid!);

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.catList.categoryName}'),
        centerTitle: true,
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<GetCatVideo>>(
                future: getCatVideo,
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return(
                        SizedBox(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context,index){
                                return GestureDetector(

                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> VideoDetailPage(getCatVideo: snapshot.data![index],)));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    width: MediaQuery.of(context).size.width,
                                    child: Card(
                                      elevation: 10,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(snapshot.data![index].videoTitle!,style: const TextStyle(fontSize: 25,color: Colors.black87),),
                                          Image.network(snapshot.data![index].videoThumbNailB!)
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                          ),
                        )
                    );
                  }
                  else
                  {
                    return const CircularProgressIndicator();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
