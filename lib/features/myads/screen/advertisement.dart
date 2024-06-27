import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../main.dart';

class Advertisement extends StatefulWidget {
  const Advertisement({super.key});

  @override
  State<Advertisement> createState() => _AdvertisementState();
}

class _AdvertisementState extends State<Advertisement> {
  // final VideoPlayerController videoPlayerController = VideoPlayerController.asset('assets/video/cat1.mp4',);
  // ChewieController ? chewieController;
  @override
  void initState() {
    // chewieController = ChewieController(videoPlayerController: videoPlayerController,
    //       aspectRatio: width*1 / height*1,
    //       autoPlay: true,
    //       looping: true,
    //       autoInitialize: true,
    //       showControls: false,
    //
    //
    //     );
    // TODO: implement initState
    super.initState();
  }
  // void dispose(){
  //   videoPlayerController.dispose();
  //   chewieController!.dispose();
  //   super.dispose();
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
      // Container(child: Chewie(controller: chewieController!)),
      Container(
        height:height*1,
          width: width*1,

          child: Image.network("https://i.pinimg.com/originals/00/b7/fb/00b7fbe00e626f1fc63919ddd0e93e11.jpg",fit: BoxFit.cover,)),
            Positioned(
              top: width*0.1,
              right: width*0.04,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 20,
                  child:Icon(CupertinoIcons.multiply_circle,size: width*0.08,) ,
                ),
              ),
            )

          ],
      ),
    );
  }
}
