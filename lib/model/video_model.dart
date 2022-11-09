class VideoModel{
  String? id;
  String? catId;
  String? videoType;
  String? videoTitle;
  String? videoUrl;
  String? videoId;
  String? videoThumbNailB;
  String? videoThumbNailS;
  String? videoDuration;
  String? videoDescription;
  String? rateAvg;
  String? totalViewer;

  VideoModel(
      this.id,
      this.catId,
      this.videoType,
      this.videoTitle,
      this.videoUrl,
      this.videoId,
      this.videoThumbNailB,
      this.videoThumbNailS,
      this.videoDuration,
      this.videoDescription,
      this.rateAvg,
      this.totalViewer,
      this.cid,
      this.categoryName,
      this.categoryImage,
      this.categoryImageThumb);

  String? cid;
  String? categoryName;
  String? categoryImage;
  String? categoryImageThumb;


}