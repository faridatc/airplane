import 'package:airplane/model/video_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_html/flutter_html.dart';
class VideoPage extends StatefulWidget {
  final VideoModel videoModel;
  const VideoPage({Key? key,required this.videoModel}) : super(key: key);
  @override
  State<VideoPage> createState() => _VideoPageState();
}
class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController videoPlayerController;
  late  ChewieController chewieController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Future<bool> initPlayer() async {
    videoPlayerController = VideoPlayerController.network(widget.videoModel.videoUrl!);
    await videoPlayerController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
    );
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.videoModel.videoTitle!),
        ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            FutureBuilder<bool>(
                future: initPlayer(),
                builder: (context, snapshot) {
                  if (snapshot.hasData == true) {
                    return Container(
                      width: double.infinity,
                      height: 200,
                      child: Chewie(
                        controller: chewieController,
                      ),
                    );
                  } else {
                    return Text('');
                  }
                }),
            Container(
              margin: EdgeInsets.only(top: 20),
              child:  SingleChildScrollView(
                child: Html(
                    data: widget.videoModel.videoDescription,
                    shrinkWrap: true,
                    style: {
                      "p": Style(
                          fontFamily: 'IranSans',
                          fontSize: FontSize.xLarge,
                          lineHeight: LineHeight.number(1.2),
                          textAlign: TextAlign.justify,
                          direction: TextDirection.rtl),
                    }),
              ),)
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }
}
