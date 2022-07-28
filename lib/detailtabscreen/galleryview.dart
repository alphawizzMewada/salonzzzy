import 'package:barber/ResponseModel/salonDetailResponse.dart';
import 'package:barber/common/widget.dart';
import 'package:barber/constant/appconstant.dart';
import 'package:barber/detailtabscreen/videoWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:video_player/video_player.dart';

class GalleryView extends StatefulWidget {
  List<Gallery> galleydataList;
  List<Video> videoList;

  GalleryView(this.galleydataList, this.videoList);

  @override
  _GalleryView createState() => _GalleryView();
}

class _GalleryView extends State<GalleryView> {
  List<Gallery> galleydataList = <Gallery>[];
  List<Video> videoList = <Video>[];
  List<String> vdeolist = <String>[];
  List<String> imaglist = <String>[];
  VideoPlayerController? _controller;
  bool selected = true;
  bool datavisible = false;
  bool nodatavisible = true;
  int j = 0;

  @override
  void initState() {
    super.initState();

    galleydataList = widget.galleydataList;

    videoList = widget.videoList;

    if (widget.galleydataList.length > 0) {
      datavisible = true;
      nodatavisible = false;

      print(galleydataList[0].imagePath);

      for (int i = 0; i < galleydataList.length; i++) {
        imaglist.add(galleydataList[i].imagePath! + galleydataList[i].image!);
      }
    } else {
      datavisible = false;
      nodatavisible = true;
    }

    // loadVideoPlayer();

    // _controller = VideoPlayerController.network(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });

    // int gallength = galleydataList.length;
    // print("gallength:$gallength");

    // for(int i = 0 ; i< galleydataList.length;i++) {
    //   imaglist.add(galleydataList[i].imagePath + galleydataList[i].image);
    // }
    //
    int imglength = imaglist.length;
    int videolength = vdeolist.length;
    print("imglength:$imglength");
    print("videolength:$videolength");
  }

  int? currentSelectedIndex;
  String? categoryname;

  loadVideoPlayer(){
    if (widget.videoList.length > 0) {
      datavisible = true;
      nodatavisible = false;

      print(videoList[0].imagePath);

      for (int i = 0; i < videoList.length; i++) {
        vdeolist.add(videoList[i].imagePath! + videoList[i].image!);

        print("Ramji:: "+'${vdeolist[i]}');
        // print("Ramji000 :: "+'${videoList[i].imagePath! + videoList[i].image!}');

        _controller = VideoPlayerController.network(
            '${vdeolist[i]}')
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          });
      }
    } else {
      datavisible = false;
      nodatavisible = true;
    }
    // _controller = VideoPlayerController.network('https://www.fluttercampus.com/video.mp4');
  }

  @override
  Widget build(BuildContext context) {
    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenwidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 45),
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              Container(
                margin:
                    EdgeInsets.only(left: 6.33.w, right: 6.33.w, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          selected = true;
                        });
                      },
                      child: AnimatedContainer(
                        width: 60,
                        height: 25,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.elasticInOut,
                        decoration: boxDecoration(
                          radius: 30.0,
                          color:
                              selected ? ColorPrimary : AppTextColorSecondary,
                          bgColor: selected ? ColorPrimary : GreyColor,
                          showShadow: true,
                        ),
                        child: Center(
                          child: text(
                            "Image",
                            textColor: !selected ? Colors.black : Colors.white,
                            fontSize: 12.5.sp,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selected = false;
                        });
                        loadVideoPlayer();
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.elasticInOut,
                        width: 60,
                        height: 25,
                        decoration: boxDecoration(
                          radius: 30.0,
                          color:
                              !selected ? ColorPrimary : AppTextColorSecondary,
                          bgColor: !selected ? ColorPrimary : GreyColor,
                          showShadow: true,
                        ),
                        child: Center(
                          child: text(
                            "Video",
                            textColor: selected ? Colors.black : Colors.white,
                            fontSize: 12.5.sp,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              selected
                  ? Visibility(
                      visible: datavisible,
                      child: SizedBox(
                        width: screenwidth * 0.8,
                        height: screenHeight * 0.8,
                        child: Container(
                          color: Colors.transparent,
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            // crossAxisCount: 4,
                            itemCount: imaglist.length,
                            itemBuilder: (BuildContext context, int index) =>
                                new Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    // color: Colors.grey,
                                    child: new Container(
                                      child: CachedNetworkImage(
                                        imageUrl: imaglist[index],
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill,
                                              alignment: Alignment.topCenter,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            SpinKitFadingCircle(
                                                color: Color(
                                                    AppConstant.pinkcolor)),
                                        errorWidget: (context, url, error) =>
                                            Image.asset("images/no_image.png"),
                                      ),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(imaglist[index]),
                                          fit: BoxFit.fitWidth,
                                          alignment: Alignment.topCenter,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    )),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 3 / 2,
                                    crossAxisSpacing: 5.0,
                                    mainAxisSpacing: 5.0),
                          ),
                        ),
                      ),
                    )
                  : Visibility(
                      visible: true,
                      child: SizedBox(
                        width: screenwidth * 0.8,
                        height: screenHeight * 0.8,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: vdeolist.length,
                          itemBuilder: (context, index){
                            return _controller!=null
                                ? Container(
                              child: Center(
                                child: _controller!.value.isInitialized
                                    ? Stack(children:[ AspectRatio(
                                  aspectRatio: _controller!.value.aspectRatio,
                                  child: VideoPlayer(_controller!),),
                                  Center(child:GestureDetector(
                                      onTap:_playPause,
                                      child:Icon(Icons.play_circle)
                                  ))
                                ])
                                    : Container(),
                              ),
                            )
                                : Center(child: CircularProgressIndicator());
                          },
                        )
                      ),
                    ),
              /* : Visibility(
                visible: true,
                child: SizedBox(
                  width: screenwidth * 0.8,
                  height: screenHeight * 0.8,
                  child: Container(
                    color: Colors.transparent,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      // crossAxisCount: 4,
                      itemCount: vdeolist.length,
                      itemBuilder: (BuildContext context, int index) =>
                      new Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          // color: Colors.grey,
                          child: new Container(
                              child:  VideoPlayer( VideoPlayerController.network(
                                  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
                                ..initialize().then((_) {
                                  // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                                  setState(() {});
                                })
                              )
                            // child: _controller.value.isInitialized
                            //     ? AspectRatio(
                            //   aspectRatio: _controller.value.aspectRatio,
                            //   child: VideoPlayer(_controller),
                            // )
                            //     : Container(),

                          )),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3/2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0
                      ),
                    ),
                  ),
                ),
              ),*/
              /*Container(
                child: _controller.value.isInitialized
                    ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
                    : Container(),
              ),*/
              Visibility(
                visible: nodatavisible,
                child: SizedBox(
                  width: screenwidth,
                  height: screenHeight * 0.5,
                  child: Container(
                    child: Center(
                      child: Container(
                          width: screenwidth,
                          height: screenHeight,
                          alignment: Alignment.center,
                          child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              Image.asset(
                                "images/nodata.png",
                                alignment: Alignment.center,
                                width: 150,
                                height: 100,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: selected
                                    ? Text(
                                        "No Images Available ",
                                        style: TextStyle(
                                            color: Color(0xFFa3a3a3),
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      )
                                    : Text(
                                        "No Videos Available ",
                                        style: TextStyle(
                                            color: Color(0xFFa3a3a3),
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: _controller!=null && !selected?FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller!.value.isPlaying
                  ? _controller!.pause()
                  : _controller!.play();
            });
          },
          child: Icon(
            _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ):SizedBox(),
      ),
    );
  }
  _playPause(){
    if(_controller!.value.isPlaying){
      _controller!.pause();
    }else{
      _controller!.play();
    }
  }
  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }
}


