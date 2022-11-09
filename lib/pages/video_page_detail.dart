import 'package:airplane/model/get_cat_video.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:video_player/video_player.dart';
class VideoDetailPage extends StatefulWidget {
  final GetCatVideo getCatVideo;

  const VideoDetailPage({Key? key, required this.getCatVideo }) : super(key: key);
  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}
class _VideoDetailPageState extends State<VideoDetailPage> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  Future<bool> initPlayer() async {
    videoPlayerController=VideoPlayerController.network(widget.getCatVideo.videoUrl!);
    await videoPlayerController.initialize();
    chewieController=ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: true
    );
    return true;
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.getCatVideo.videoTitle!),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          FutureBuilder<bool>(
            future: initPlayer(),
            builder: (context,snapshot){
              if(snapshot.hasData==true)
                {
                  return Container(
                    width: double.infinity,
                    height: 300,
                    child: Chewie(
                      controller: chewieController,
                    ),
                  );
                }
              else
                {
                  return  const Text('');
                }
            },
          ),
          Container(
            child:  SingleChildScrollView(
              child: Html(
                  data: widget.getCatVideo.videoDescription,
                  shrinkWrap: true,
                  style: {
                    "p": Style(
                        fontSize: FontSize.xLarge,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'IranSans',
                        lineHeight: LineHeight.number(1.2),
                        textAlign: TextAlign.justify,
                        direction: TextDirection.rtl),
                  }),
            ),)
        ],
      )
    );
  }
  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

}

